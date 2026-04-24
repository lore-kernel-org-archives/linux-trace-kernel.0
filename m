Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD23D88E1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Apr 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039383; cv=none; b=MnIGGNP9+lrdVt3nV3PzrYtyecsRUncdAjzTQrCuD4MQirf4dUicJZvyPaod4dM/6xwdsOwgJ7CAyL/ZLURSg7LEA4w2oebpVgMTkFXFx+VZ72opVYHUxzuFr38KNhpBjHUY10VJQsZ75PtgNx0dIbgWJVP/ftZ1ZGkOwlRqnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039383; c=relaxed/simple;
	bh=zyIYqcWZ0wCijwFWczsFYEYh/s9xxj74CVtmgAIJ8HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=I8Nay4KKpwEdQOCmre61V46bZsQZcAYxZy96MNhfTJMbMuImSDEQQh/5shZ5uPf6q9FiDfzZMiBTDyWtnn87E1+1op0Kwuu+YiOMr3Ewpr93agjF+bn/7kR9LnOJN2faPSTCgiXcJO73iV4OkvvJLFoacsqHQ6xzHr10pw95iaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbDRvZix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbDRvZix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iC2saqr83NAV7BACc+HkW2M5Q8h3PcOhfbXWvFa8fC0=;
	b=MbDRvZixpDbNB58zGxIyoOzD4YeAfPt4b2NA39A3Guw7IHhBUUFZpUNdWzRiAB6ndcvVY6
	6uOipBEcOKda9bGwov0kLhwuW7yNE1bnwWjDxcrsrnEjU1CybmiTgKmBdwzrXJD1dUAywz
	C7yh6YZTdYIfroyYyeGICM0ivPGKndU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-l02U12oMOTauxztD4PZyEg-1; Fri,
 24 Apr 2026 10:02:56 -0400
X-MC-Unique: l02U12oMOTauxztD4PZyEg-1
X-Mimecast-MFC-AGG-ID: l02U12oMOTauxztD4PZyEg_1777039375
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99CD519560BD;
	Fri, 24 Apr 2026 14:02:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCE77196B8F6;
	Fri, 24 Apr 2026 14:02:52 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] rtla/tests: Add unit tests for actions module
Date: Fri, 24 Apr 2026 16:02:44 +0200
Message-ID: <20260424140244.958495-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ImIrwf_miSW9-CdEeSiynrOhpe3b0Gs1LRkpiGTdm9c_1777039375
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add unit tests covering all functions in the actions module, including
both valid and invalid inputs and all action types, except for
actions_perform(), where only shell and continue actions are tested.

To support testing multiple modules, the unit test build was modified so
that it links the entire rtla-in.o file. For this to work, the main()
function in rtla.c was declared weak, so that the unit test main is able
to override it.

Other included minor changes to unit tests are:

- Make unit test output verbose to show which tests are being run, now
  that we have more than 3 tests.
- Add unit_tests file to .gitignore.
- Split unit test sources to one file per test suite, and keep only
  main() function in unit_tests.c.
- Fix Makefile dependencies so that "make unit-tests" will rebuild the
  binary with the changes in the commit.

Also with the linking the entire rtla-in.o file, it now has rtla's
nr_cpus symbol, so the declaration in utils unit tests is made extern.

Assisted-by: Composer:composer-2-fast
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/.gitignore               |   1 +
 tools/tracing/rtla/src/rtla.c               |   3 +
 tools/tracing/rtla/tests/unit/Build         |   3 +-
 tools/tracing/rtla/tests/unit/Makefile.unit |   6 +-
 tools/tracing/rtla/tests/unit/actions.c     | 380 ++++++++++++++++++++
 tools/tracing/rtla/tests/unit/unit_tests.c  | 107 +-----
 tools/tracing/rtla/tests/unit/utils.c       | 106 ++++++
 7 files changed, 502 insertions(+), 104 deletions(-)
 create mode 100644 tools/tracing/rtla/tests/unit/actions.c
 create mode 100644 tools/tracing/rtla/tests/unit/utils.c

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index 4d39d64ac08c..231fb8d67f97 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 rtla
 rtla-static
+unit_tests
 fixdep
 feature
 FEATURE-DUMP
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
index 7635c70123ab..3398250076ea 100644
--- a/tools/tracing/rtla/src/rtla.c
+++ b/tools/tracing/rtla/src/rtla.c
@@ -61,6 +61,9 @@ int run_command(int argc, char **argv, int start_position)
 	return 1;
 }
 
+/* Set main as weak to allow overriding it for building unit test binary */
+#pragma weak main
+
 int main(int argc, char *argv[])
 {
 	int retval;
diff --git a/tools/tracing/rtla/tests/unit/Build b/tools/tracing/rtla/tests/unit/Build
index 5f1e531ea8c9..2749f4cf202a 100644
--- a/tools/tracing/rtla/tests/unit/Build
+++ b/tools/tracing/rtla/tests/unit/Build
@@ -1,2 +1,3 @@
+unit_tests-y += utils.o
+unit_tests-y += actions.o
 unit_tests-y += unit_tests.o
-unit_tests-y +=../../src/utils.o
diff --git a/tools/tracing/rtla/tests/unit/Makefile.unit b/tools/tracing/rtla/tests/unit/Makefile.unit
index 2088c9cc3571..bacb00164e46 100644
--- a/tools/tracing/rtla/tests/unit/Makefile.unit
+++ b/tools/tracing/rtla/tests/unit/Makefile.unit
@@ -3,10 +3,10 @@
 UNIT_TESTS := $(OUTPUT)unit_tests
 UNIT_TESTS_IN := $(UNIT_TESTS)-in.o
 
-$(UNIT_TESTS): $(UNIT_TESTS_IN)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ -lcheck
+$(UNIT_TESTS): $(UNIT_TESTS_IN) $(RTLA_IN)
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $^ $(EXTLIBS) -lcheck
 
-$(UNIT_TESTS_IN):
+$(UNIT_TESTS_IN): fixdep
 	make $(build)=unit_tests
 
 unit-tests: FORCE
diff --git a/tools/tracing/rtla/tests/unit/actions.c b/tools/tracing/rtla/tests/unit/actions.c
new file mode 100644
index 000000000000..a5808ab71a4d
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/actions.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <signal.h>
+
+#include "../../src/actions.h"
+
+static struct actions actions_fixture;
+
+static void actions_fixture_setup(void)
+{
+	actions_init(&actions_fixture);
+}
+
+static void actions_fixture_teardown(void)
+{
+	actions_destroy(&actions_fixture);
+}
+
+START_TEST(test_actions_init)
+{
+	struct actions actions;
+
+	actions_init(&actions);
+
+	ck_assert_int_eq(actions.len, 0);
+	ck_assert_int_eq(actions.size, action_default_size);
+	ck_assert(!actions.continue_flag);
+	ck_assert_ptr_eq(actions.trace_output_inst, NULL);
+}
+END_TEST
+
+START_TEST(test_actions_destroy)
+{
+	struct actions actions;
+
+	actions_init(&actions);
+	actions_destroy(&actions);
+}
+END_TEST
+
+START_TEST(test_actions_reallocate)
+{
+	struct actions actions;
+	int i;
+
+	actions_init(&actions);
+
+	ck_assert_int_eq(actions.len, 0);
+	ck_assert_int_eq(actions.size, action_default_size);
+
+	/* Fill size of actions array */
+	for (i = 0; i < action_default_size; i++)
+		actions_add_continue(&actions);
+
+	ck_assert_int_eq(actions.len, action_default_size);
+	ck_assert_int_eq(actions.size, action_default_size);
+
+	/* Add one more action to trigger reallocation */
+	actions_add_continue(&actions);
+
+	ck_assert_int_eq(actions.len, action_default_size + 1);
+	ck_assert_int_eq(actions.size, action_default_size * 2);
+
+	actions_destroy(&actions);
+}
+END_TEST
+
+START_TEST(test_actions_add_trace_output)
+{
+	actions_add_trace_output(&actions_fixture, "trace_output.txt");
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions_fixture.list[0].trace_output, "trace_output.txt");
+	ck_assert(actions_fixture.present[ACTION_TRACE_OUTPUT]);
+}
+END_TEST
+
+START_TEST(test_actions_add_signal)
+{
+	actions_add_signal(&actions_fixture, SIGINT, 1234);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_SIGNAL);
+	ck_assert_int_eq(actions_fixture.list[0].signal, SIGINT);
+	ck_assert_int_eq(actions_fixture.list[0].pid, 1234);
+	ck_assert(actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_add_shell)
+{
+	actions_add_shell(&actions_fixture, "echo Hello");
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_SHELL);
+	ck_assert_str_eq(actions_fixture.list[0].command, "echo Hello");
+	ck_assert(actions_fixture.present[ACTION_SHELL]);
+}
+END_TEST
+
+START_TEST(test_actions_add_continue)
+{
+	actions_add_continue(&actions_fixture);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_CONTINUE);
+	ck_assert(actions_fixture.present[ACTION_CONTINUE]);
+}
+END_TEST
+
+START_TEST(test_actions_add_multiple_same_action)
+{
+	actions_add_trace_output(&actions_fixture, "trace1.txt");
+	actions_add_trace_output(&actions_fixture, "trace2.txt");
+
+	ck_assert_int_eq(actions_fixture.len, 2);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions_fixture.list[0].trace_output, "trace1.txt");
+	ck_assert_int_eq(actions_fixture.list[1].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions_fixture.list[1].trace_output, "trace2.txt");
+	ck_assert(actions_fixture.present[ACTION_TRACE_OUTPUT]);
+}
+END_TEST
+
+START_TEST(test_actions_add_multiple_different_action)
+{
+	actions_add_trace_output(&actions_fixture, "trace_output.txt");
+	actions_add_signal(&actions_fixture, SIGINT, 1234);
+
+	ck_assert_int_eq(actions_fixture.len, 2);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions_fixture.list[0].trace_output, "trace_output.txt");
+	ck_assert(actions_fixture.present[ACTION_TRACE_OUTPUT]);
+	ck_assert_int_eq(actions_fixture.list[1].type, ACTION_SIGNAL);
+	ck_assert_int_eq(actions_fixture.list[1].signal, SIGINT);
+	ck_assert_int_eq(actions_fixture.list[1].pid, 1234);
+	ck_assert(actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_trace_output)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "trace", "trace.txt"), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions_fixture.list[0].trace_output, "trace.txt");
+	ck_assert(actions_fixture.present[ACTION_TRACE_OUTPUT]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_trace_output_arg)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "trace,file=trace2.txt", "trace1.txt"), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_TRACE_OUTPUT);
+	ck_assert_str_eq(actions_fixture.list[0].trace_output, "trace2.txt");
+	ck_assert(actions_fixture.present[ACTION_TRACE_OUTPUT]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_trace_output_arg_bad)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "trace,foo=bar", "trace_output.txt"), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_TRACE_OUTPUT]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal,num=1,pid=1234", NULL), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_SIGNAL);
+	ck_assert_int_eq(actions_fixture.list[0].signal, 1);
+	ck_assert_int_eq(actions_fixture.list[0].pid, 1234);
+	ck_assert(actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal_swapped)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal,pid=1234,num=1", NULL), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_SIGNAL);
+	ck_assert_int_eq(actions_fixture.list[0].signal, 1);
+	ck_assert_int_eq(actions_fixture.list[0].pid, 1234);
+	ck_assert(actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal_parent)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal,pid=parent,num=1", NULL), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_SIGNAL);
+	ck_assert_int_eq(actions_fixture.list[0].signal, 1);
+	ck_assert_int_eq(actions_fixture.list[0].pid, -1);
+	ck_assert(actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal_no_arg)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal_no_pid)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal,num=1", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal_no_num)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal,pid=1234", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_signal_arg_bad)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "signal,foo=bar", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_SIGNAL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_shell)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "shell,command=echo Hello", NULL), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_SHELL);
+	ck_assert_str_eq(actions_fixture.list[0].command, "echo Hello");
+	ck_assert(actions_fixture.present[ACTION_SHELL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_shell_no_arg)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "shell", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_SHELL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_shell_arg_bad)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "shell,foo=bar", NULL), -1);
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_SHELL]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_continue)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "continue", NULL), 0);
+
+	ck_assert_int_eq(actions_fixture.len, 1);
+	ck_assert_int_eq(actions_fixture.list[0].type, ACTION_CONTINUE);
+	ck_assert(actions_fixture.present[ACTION_CONTINUE]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_continue_arg_bad)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "continue,foo=bar", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+	ck_assert(!actions_fixture.present[ACTION_CONTINUE]);
+}
+END_TEST
+
+START_TEST(test_actions_parse_invalid)
+{
+	ck_assert_int_eq(actions_parse(&actions_fixture, "foobar", NULL), -1);
+
+	ck_assert_int_eq(actions_fixture.len, 0);
+}
+END_TEST
+
+START_TEST(test_actions_perform_continue)
+{
+	actions_add_continue(&actions_fixture);
+	ck_assert_int_eq(actions_perform(&actions_fixture), 0);
+
+	ck_assert(actions_fixture.continue_flag);
+}
+END_TEST
+
+START_TEST(test_actions_perform_continue_after_successful_shell_command)
+{
+	actions_add_shell(&actions_fixture, "exit 0");
+	actions_add_continue(&actions_fixture);
+	ck_assert_int_eq(actions_perform(&actions_fixture), 0 << 8);
+
+	ck_assert(actions_fixture.continue_flag);
+}
+END_TEST
+
+START_TEST(test_actions_perform_continue_after_failed_shell_command)
+{
+	actions_add_shell(&actions_fixture, "exit 1");
+	actions_add_continue(&actions_fixture);
+	ck_assert_int_eq(actions_perform(&actions_fixture), 1 << 8);
+
+	ck_assert(!actions_fixture.continue_flag);
+}
+END_TEST
+
+Suite *actions_suite(void)
+{
+	Suite *s = suite_create("actions");
+	TCase *tc;
+
+	tc = tcase_create("alloc");
+	tcase_add_test(tc, test_actions_init);
+	tcase_add_test(tc, test_actions_destroy);
+	tcase_add_test(tc, test_actions_reallocate);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("add");
+	tcase_add_checked_fixture(tc, actions_fixture_setup, actions_fixture_teardown);
+	tcase_add_test(tc, test_actions_add_trace_output);
+	tcase_add_test(tc, test_actions_add_signal);
+	tcase_add_test(tc, test_actions_add_shell);
+	tcase_add_test(tc, test_actions_add_continue);
+	tcase_add_test(tc, test_actions_add_multiple_same_action);
+	tcase_add_test(tc, test_actions_add_multiple_different_action);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("parse");
+	tcase_add_checked_fixture(tc, actions_fixture_setup, actions_fixture_teardown);
+	tcase_add_test(tc, test_actions_parse_trace_output);
+	tcase_add_test(tc, test_actions_parse_trace_output_arg);
+	tcase_add_test(tc, test_actions_parse_trace_output_arg_bad);
+	tcase_add_test(tc, test_actions_parse_signal);
+	tcase_add_test(tc, test_actions_parse_signal_swapped);
+	tcase_add_test(tc, test_actions_parse_signal_parent);
+	tcase_add_test(tc, test_actions_parse_signal_no_arg);
+	tcase_add_test(tc, test_actions_parse_signal_no_pid);
+	tcase_add_test(tc, test_actions_parse_signal_no_num);
+	tcase_add_test(tc, test_actions_parse_signal_arg_bad);
+	tcase_add_test(tc, test_actions_parse_shell);
+	tcase_add_test(tc, test_actions_parse_shell_no_arg);
+	tcase_add_test(tc, test_actions_parse_shell_arg_bad);
+	tcase_add_test(tc, test_actions_parse_continue);
+	tcase_add_test(tc, test_actions_parse_continue_arg_bad);
+	tcase_add_test(tc, test_actions_parse_invalid);
+	suite_add_tcase(s, tc);
+
+	tc = tcase_create("perform");
+	tcase_add_checked_fixture(tc, actions_fixture_setup, actions_fixture_teardown);
+	tcase_add_test(tc, test_actions_perform_continue);
+	tcase_add_test(tc, test_actions_perform_continue_after_successful_shell_command);
+	tcase_add_test(tc, test_actions_perform_continue_after_failed_shell_command);
+	suite_add_tcase(s, tc);
+
+	return s;
+}
diff --git a/tools/tracing/rtla/tests/unit/unit_tests.c b/tools/tracing/rtla/tests/unit/unit_tests.c
index f3c6d89e3300..f87d761f9b12 100644
--- a/tools/tracing/rtla/tests/unit/unit_tests.c
+++ b/tools/tracing/rtla/tests/unit/unit_tests.c
@@ -2,115 +2,22 @@
 
 #define _GNU_SOURCE
 #include <check.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sched.h>
-#include <limits.h>
-#include <unistd.h>
-#include <sys/sysinfo.h>
+#include <stdbool.h>
 
 #include "../../src/utils.h"
-int nr_cpus;
 
-START_TEST(test_strtoi)
-{
-	int result;
-	char buf[64];
-
-	ck_assert_int_eq(strtoi("123", &result), 0);
-	ck_assert_int_eq(result, 123);
-	ck_assert_int_eq(strtoi(" -456", &result), 0);
-	ck_assert_int_eq(result, -456);
-
-	snprintf(buf, sizeof(buf), "%d", INT_MAX);
-	ck_assert_int_eq(strtoi(buf, &result), 0);
-	snprintf(buf, sizeof(buf), "%ld", (long)INT_MAX + 1);
-	ck_assert_int_eq(strtoi(buf, &result), -1);
-
-	ck_assert_int_eq(strtoi("", &result), -1);
-	ck_assert_int_eq(strtoi("123abc", &result), -1);
-	ck_assert_int_eq(strtoi("123 ", &result), -1);
-}
-END_TEST
-
-START_TEST(test_parse_cpu_set)
-{
-	cpu_set_t set;
+Suite *utils_suite(void);
+Suite *actions_suite(void);
 
-	nr_cpus = 8;
-	ck_assert_int_eq(parse_cpu_set("0", &set), 0);
-	ck_assert(CPU_ISSET(0, &set));
-	ck_assert(!CPU_ISSET(1, &set));
-
-	ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
-	ck_assert(CPU_ISSET(0, &set));
-	ck_assert(CPU_ISSET(2, &set));
-
-	ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
-	ck_assert(CPU_ISSET(0, &set));
-	ck_assert(CPU_ISSET(1, &set));
-	ck_assert(CPU_ISSET(2, &set));
-	ck_assert(CPU_ISSET(3, &set));
-
-	ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
-	ck_assert(!CPU_ISSET(0, &set));
-	ck_assert(CPU_ISSET(1, &set));
-	ck_assert(CPU_ISSET(2, &set));
-	ck_assert(CPU_ISSET(3, &set));
-	ck_assert(!CPU_ISSET(4, &set));
-	ck_assert(CPU_ISSET(5, &set));
-
-	ck_assert_int_eq(parse_cpu_set("-1", &set), 1);
-	ck_assert_int_eq(parse_cpu_set("abc", &set), 1);
-	ck_assert_int_eq(parse_cpu_set("9999", &set), 1);
-}
-END_TEST
-
-START_TEST(test_parse_prio)
-{
-	struct sched_attr attr;
-
-	ck_assert_int_eq(parse_prio("f:50", &attr), 0);
-	ck_assert_uint_eq(attr.sched_policy, SCHED_FIFO);
-	ck_assert_uint_eq(attr.sched_priority, 50U);
-
-	ck_assert_int_eq(parse_prio("r:30", &attr), 0);
-	ck_assert_uint_eq(attr.sched_policy, SCHED_RR);
-
-	ck_assert_int_eq(parse_prio("o:0", &attr), 0);
-	ck_assert_uint_eq(attr.sched_policy, SCHED_OTHER);
-	ck_assert_int_eq(attr.sched_nice, 0);
-
-	ck_assert_int_eq(parse_prio("d:10ms:100ms", &attr), 0);
-	ck_assert_uint_eq(attr.sched_policy, 6U);
-
-	ck_assert_int_eq(parse_prio("f:999", &attr), -1);
-	ck_assert_int_eq(parse_prio("o:-20", &attr), -1);
-	ck_assert_int_eq(parse_prio("d:100ms:10ms", &attr), -1);
-	ck_assert_int_eq(parse_prio("x:50", &attr), -1);
-}
-END_TEST
-
-Suite *utils_suite(void)
-{
-	Suite *s = suite_create("utils");
-	TCase *tc = tcase_create("core");
-
-	tcase_add_test(tc, test_strtoi);
-	tcase_add_test(tc, test_parse_cpu_set);
-	tcase_add_test(tc, test_parse_prio);
-
-	suite_add_tcase(s, tc);
-	return s;
-}
-
-int main(void)
+int main(int argc, char *argv[])
 {
 	int num_failed;
 	SRunner *sr;
 
 	sr = srunner_create(utils_suite());
-	srunner_run_all(sr, CK_NORMAL);
+	srunner_add_suite(sr, actions_suite());
+
+	srunner_run_all(sr, CK_VERBOSE);
 	num_failed = srunner_ntests_failed(sr);
 
 	srunner_free(sr);
diff --git a/tools/tracing/rtla/tests/unit/utils.c b/tools/tracing/rtla/tests/unit/utils.c
new file mode 100644
index 000000000000..ce53cab49457
--- /dev/null
+++ b/tools/tracing/rtla/tests/unit/utils.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <check.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <limits.h>
+#include <unistd.h>
+#include <sys/sysinfo.h>
+
+#include "../../src/utils.h"
+
+extern int nr_cpus;
+
+START_TEST(test_strtoi)
+{
+	int result;
+	char buf[64];
+
+	ck_assert_int_eq(strtoi("123", &result), 0);
+	ck_assert_int_eq(result, 123);
+	ck_assert_int_eq(strtoi(" -456", &result), 0);
+	ck_assert_int_eq(result, -456);
+
+	snprintf(buf, sizeof(buf), "%d", INT_MAX);
+	ck_assert_int_eq(strtoi(buf, &result), 0);
+	snprintf(buf, sizeof(buf), "%ld", (long)INT_MAX + 1);
+	ck_assert_int_eq(strtoi(buf, &result), -1);
+
+	ck_assert_int_eq(strtoi("", &result), -1);
+	ck_assert_int_eq(strtoi("123abc", &result), -1);
+	ck_assert_int_eq(strtoi("123 ", &result), -1);
+}
+END_TEST
+
+START_TEST(test_parse_cpu_set)
+{
+	cpu_set_t set;
+
+	nr_cpus = 8;
+	ck_assert_int_eq(parse_cpu_set("0", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(!CPU_ISSET(1, &set));
+
+	ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(2, &set));
+
+	ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(1, &set));
+	ck_assert(CPU_ISSET(2, &set));
+	ck_assert(CPU_ISSET(3, &set));
+
+	ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
+	ck_assert(!CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(1, &set));
+	ck_assert(CPU_ISSET(2, &set));
+	ck_assert(CPU_ISSET(3, &set));
+	ck_assert(!CPU_ISSET(4, &set));
+	ck_assert(CPU_ISSET(5, &set));
+
+	ck_assert_int_eq(parse_cpu_set("-1", &set), 1);
+	ck_assert_int_eq(parse_cpu_set("abc", &set), 1);
+	ck_assert_int_eq(parse_cpu_set("9999", &set), 1);
+}
+END_TEST
+
+START_TEST(test_parse_prio)
+{
+	struct sched_attr attr;
+
+	ck_assert_int_eq(parse_prio("f:50", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, SCHED_FIFO);
+	ck_assert_uint_eq(attr.sched_priority, 50U);
+
+	ck_assert_int_eq(parse_prio("r:30", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, SCHED_RR);
+
+	ck_assert_int_eq(parse_prio("o:0", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, SCHED_OTHER);
+	ck_assert_int_eq(attr.sched_nice, 0);
+
+	ck_assert_int_eq(parse_prio("d:10ms:100ms", &attr), 0);
+	ck_assert_uint_eq(attr.sched_policy, 6U);
+
+	ck_assert_int_eq(parse_prio("f:999", &attr), -1);
+	ck_assert_int_eq(parse_prio("o:-20", &attr), -1);
+	ck_assert_int_eq(parse_prio("d:100ms:10ms", &attr), -1);
+	ck_assert_int_eq(parse_prio("x:50", &attr), -1);
+}
+END_TEST
+
+Suite *utils_suite(void)
+{
+	Suite *s = suite_create("utils");
+	TCase *tc = tcase_create("core");
+
+	tcase_add_test(tc, test_strtoi);
+	tcase_add_test(tc, test_parse_cpu_set);
+	tcase_add_test(tc, test_parse_prio);
+
+	suite_add_tcase(s, tc);
+	return s;
+}
-- 
2.53.0

