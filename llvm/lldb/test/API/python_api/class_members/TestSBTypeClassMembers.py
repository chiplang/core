"""
Test SBType APIs to fetch member function types.
"""


import lldb
from lldbsuite.test.decorators import *
from lldbsuite.test.lldbtest import *
from lldbsuite.test import lldbutil


class SBTypeMemberFunctionsTest(TestBase):
    def setUp(self):
        # Call super's setUp().
        TestBase.setUp(self)
        # We'll use the test method name as the exe_name.
        self.exe_name = self.testMethodName
        # Find the line number to break at.
        self.source = "main.mm"
        self.line = line_number(self.source, "// set breakpoint here")

    @skipUnlessDarwin
    def test(self):
        """Test SBType APIs to fetch member function types."""
        d = {"EXE": self.exe_name}
        self.build(dictionary=d)
        self.setTearDownCleanup(dictionary=d)
        exe = self.getBuildArtifact(self.exe_name)

        # Create a target by the debugger.
        target = self.dbg.CreateTarget(exe)
        self.assertTrue(target, VALID_TARGET)

        # Create the breakpoint inside function 'main'.
        breakpoint = target.BreakpointCreateByLocation(self.source, self.line)
        self.assertTrue(breakpoint, VALID_BREAKPOINT)

        # Now launch the process, and do not stop at entry point.
        process = target.LaunchSimple(None, None, self.get_process_working_directory())
        self.assertTrue(process, PROCESS_IS_VALID)

        # Get Frame #0.
        self.assertState(process.GetState(), lldb.eStateStopped)
        thread = lldbutil.get_stopped_thread(process, lldb.eStopReasonBreakpoint)
        self.assertTrue(
            thread.IsValid(),
            "There should be a thread stopped due to breakpoint condition",
        )
        frame0 = thread.GetFrameAtIndex(0)

        variable = frame0.FindVariable("d")
        Derived = variable.GetType()
        Base = Derived.GetDirectBaseClassAtIndex(0).GetType()

        self.assertEqual(
            2, Derived.GetNumberOfMemberFunctions(), "Derived declares two methods"
        )
        self.assertEqual(
            "int",
            Derived.GetMemberFunctionAtIndex(0)
            .GetType()
            .GetFunctionReturnType()
            .GetName(),
            "Derived::dImpl returns int",
        )

        self.assertEqual(
            4, Base.GetNumberOfMemberFunctions(), "Base declares three methods"
        )
        self.assertEqual(
            3,
            Base.GetMemberFunctionAtIndex(3)
            .GetType()
            .GetFunctionArgumentTypes()
            .GetSize(),
            "Base::sfunc takes three arguments",
        )
        self.assertEqual(
            "sfunc", Base.GetMemberFunctionAtIndex(3).GetName(), "Base::sfunc not found"
        )
        self.assertEqual(
            lldb.eMemberFunctionKindStaticMethod,
            Base.GetMemberFunctionAtIndex(3).GetKind(),
            "Base::sfunc is a static",
        )
        self.assertEqual(
            0,
            Base.GetMemberFunctionAtIndex(2)
            .GetType()
            .GetFunctionArgumentTypes()
            .GetSize(),
            "Base::dat takes no arguments",
        )
        self.assertEqual(
            "char",
            Base.GetMemberFunctionAtIndex(1)
            .GetType()
            .GetFunctionArgumentTypes()
            .GetTypeAtIndex(1)
            .GetName(),
            "Base::bar takes a second 'char' argument",
        )
        self.assertEqual(
            "bar", Base.GetMemberFunctionAtIndex(1).GetName(), "Base::bar not found"
        )

        variable = frame0.FindVariable("thingy")
        Thingy = variable.GetType()

        self.assertEqual(
            2, Thingy.GetNumberOfMemberFunctions(), "Thingy declares two methods"
        )

        self.assertEqual(
            "id",
            Thingy.GetMemberFunctionAtIndex(0).GetReturnType().GetName(),
            "Thingy::init returns an id",
        )
        self.assertEqual(
            2,
            Thingy.GetMemberFunctionAtIndex(1).GetNumberOfArguments(),
            "Thingy::foo takes two arguments",
        )
        self.assertEqual(
            "int",
            Thingy.GetMemberFunctionAtIndex(1).GetArgumentTypeAtIndex(0).GetName(),
            "Thingy::foo takes an int",
        )

        self.assertEqual(
            "Derived::dImpl()", Derived.GetMemberFunctionAtIndex(0).GetDemangledName()
        )
        self.assertEqual(
            "Derived::baz(float)",
            Derived.GetMemberFunctionAtIndex(1).GetDemangledName(),
        )
        self.assertEqual(
            "Base::foo(int, int)", Base.GetMemberFunctionAtIndex(0).GetDemangledName()
        )
        self.assertEqual(
            "Base::bar(int, char)", Base.GetMemberFunctionAtIndex(1).GetDemangledName()
        )
        self.assertEqual(
            "Base::dat()", Base.GetMemberFunctionAtIndex(2).GetDemangledName()
        )
        self.assertEqual(
            "Base::sfunc(char, int, float)",
            Base.GetMemberFunctionAtIndex(3).GetDemangledName(),
        )

        self.assertEqual(
            "_ZN7Derived5dImplEv", Derived.GetMemberFunctionAtIndex(0).GetMangledName()
        )
        self.assertEqual(
            "_ZN7Derived3bazEf", Derived.GetMemberFunctionAtIndex(1).GetMangledName()
        )
        self.assertEqual(
            "_ZN4Base3fooEii", Base.GetMemberFunctionAtIndex(0).GetMangledName()
        )
        self.assertEqual(
            "_ZN4Base3barEic", Base.GetMemberFunctionAtIndex(1).GetMangledName()
        )
        self.assertEqual(
            "_ZN4Base3datEv", Base.GetMemberFunctionAtIndex(2).GetMangledName()
        )
        self.assertEqual(
            "_ZN4Base5sfuncEcif", Base.GetMemberFunctionAtIndex(3).GetMangledName()
        )
