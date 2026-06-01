Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633603630B3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348556; cv=none; b=GLYXPQM1vigV9itoQ4B/pSUSsc6GQ4lGlmoQSWAIOcpe7bdqB1hsqubUl8r2Cxi/SrG2vJng+ATsybwhja+DzLiVwgTILPM+bmevp4YxMoKRrwMVpsPEFbjwtWrwAcGok6G8Sy29i3OTUm/qzAvDHqP9LrM1MhimscN/ecFKFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348556; c=relaxed/simple;
	bh=7EB6bOzzY3N4v7wADQ6k7HpVhyojDxG0mhAtqoCnbSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slKjHMz/E0cLiHrcZswiO/MN5weZXSgu8dZbGOGbr+n9qo8x3IJvIFzWQrx/wKPuarcL7rfirN24hBa5DxKbMim2tWCXioHW/TjEhLXxpIbVXnHo6sfnpNKnlPZY3XDe/Wk8cxznJEPwZE/d3A1IMnZmE5JbxgPHQd2OoBWPDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOMohT37; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOMohT37"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9155183b42cso217018985a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 14:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780348554; x=1780953354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=etvv1aoxY7mAHojyNHCJWZxBLbP6ZnRhPDJQ2A0dhAU=;
        b=LOMohT37S2/PKhpqPdHfgHqW+ZQL+zzYYtO509kaioJHnbzJ1wU50U1CLCBbyNzCXu
         XQxm55l7QpL2glZOT7/Uwe+RKIoyQ/ORhLTrxVd1jDnZIKzVN1ZZ4SEJoJEtckclmQW/
         7mGjkS8tvVINzAcu+0x3GLdbLMjoEBQb6ZhTuxZfQv913M+ak8yz9FlNLHrARpLCEP9Q
         TjIIlBtlo0zrNE4hceLKRj63UXyaHamMKKwKWReatrc8p56sgXZnLd4G70MlnjukpfKH
         25C0ifgMsyWJBx45hS4O0Aqfgt879r2HDa1xcofe+/35hphQFCqmUWnfP+8hiM21nKEQ
         fuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780348554; x=1780953354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etvv1aoxY7mAHojyNHCJWZxBLbP6ZnRhPDJQ2A0dhAU=;
        b=GWpusjINidPTIW7mtk2eBGUyp4r/buP0r+Nc4/OwL5WfIEv8YtLBE4RL5AH0HslNpa
         2Y8CnhInGCmBZgPsQ6SrItZk1vLiGbA4D0TfzsI0fZrZ3mfJMu1OsyzqLZaYV0m6to0z
         JUY2ko7WIvABcdeR8gdzLcbPPbbiKq5Y3k545mVR4QmgLjzOuJ3dyZWU0FIkeIcxmFCq
         2aA+4pU2/0taQVMhZgsl455Axu5D9q4DoBGowIXqp0oHIJ4srNeRSBAga3JKD6ZB+Yf5
         uGmCdLQdElGhV8AyH6EZzS7b9IvxrmBtHWJvw5YhLedVtVEMnSk2TI/AWV+QPUmCnnf8
         dH/A==
X-Forwarded-Encrypted: i=1; AFNElJ+vCuGK/E8Nn7jgB8VUIaJ15HHk6LC2jHerz6wZcriM+4V+y055HbubcXX5yI7TAQCl2AH3GrcZqJQxcnMxEDOA9W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pJM2qCJGuzGXcSkRRDPnnJza4Q074F9t6FBC0Pi0O5epqq2K
	Np/fNVaNVpwfr26kMGGBKSG3EmpFhAZgzRXOYL4bQ89Sp7i6u7bWZ6/R
X-Gm-Gg: Acq92OHO/aQmlm/0nT7qvEcwEjMZrLRzwTsHpNxad1ONZdmyt5gSmUSxGo79LkYwgHa
	cONs7u4y77m/OHkkx418Bi5HokdMw9YKZXe9ILlVpWykWtjw82VuDzvagiup0K6E5+R/obWVdd0
	lv8crdMHxLovoyW2mbS24NjHZAhSuLbVzpzddJhBnX+4NDyI8FMUF12qZ4dXMc3tWJltyUB1WPp
	UW4Y4DdkxD+/ON3SZuaYSNl6m3QlUdjwpEp65eoUItxsm/OP2nYYCY4aO3s+BKAju1Rc8+VnkMY
	/2C+MmP4i9gp1lUt1t0YguhsmCzn6ZThQDQIioPZ5XWrBYyFZnpKsj0QOkoeQKJbXIwupcVxlO+
	8WJ7H15nDmdHq1SzFdz70rHIQ49sjY0TfdKF1j3uhOcg/APRnqUr+vh3qim2iWEYfmGbLMTo3KM
	iwpm0RSkyfs1oPqxEAuqqiX3dMnBC1C2q07QNNpWXDTg24vv2QSWrFDiuZFLsthXzrMSPoCoWAh
	gwL8m4ttq0BWry1Ebrm9Od+fOPYOg==
X-Received: by 2002:a05:620a:2592:b0:912:5d2a:4bd1 with SMTP id af79cd13be357-91578039e1emr195359285a.40.1780348554324;
        Mon, 01 Jun 2026 14:15:54 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265d794sm1099641185a.47.2026.06.01.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:15:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtla/timerlat: Fix parsing of short options with attached arguments
Date: Mon,  1 Jun 2026 17:15:36 -0400
Message-ID: <20260601211538.381649-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timerlat hist command fails to parse short options with attached
numeric arguments (e.g., -p100) due to conflicts between digit characters
used as option values and numeric arguments to other options.

This issue was discovered when testing rtla 7.1.0-rc6 with rteval,
which passes arguments in the compact -p100 format. The rteval tests
failed with the confusing error "no-irq and no-thread set, there is
nothing to do here" even though neither option was specified.

The root cause is two-fold:

1. Digit characters ('0'-'9') were used as short option values for
   long-only options like --no-irq, --no-thread, etc. This caused
   getopt_auto() to generate an option string like 'a:b:...:u0123456:7:8:9'
   which made getopt treat digits as valid option characters.

2. The two-phase option parsing approach (alternating calls between
   common_parse_options() and local option parsing) confused getopt's
   internal state when encountering arguments like -p100.

When a user passed -p100, getopt would incorrectly parse it as three
separate options: -p, -1, -0, and -0, silently setting no_irq and
no_thread flags instead of recognizing "100" as the period argument.

The two-phase parsing was introduced in commit 850cd24cb6d6 ("tools/rtla:
Add common_parse_options()") which first appeared in v7.0-rc1. Prior to
that commit, -p100 worked correctly. The digit characters as option
values existed since the original timerlat implementation, but only
became problematic when combined with the two-phase parsing approach.

Fix this by:

1. Eliminating digit characters from the option string by filtering them
   out in getopt_auto(). This prevents conflicts with numeric arguments.

2. Refactoring timerlat_hist_parse_args() to use single-pass option
   parsing. Instead of alternating between common_parse_options() and
   local parsing, merge all options (common and local) into a single
   option table and parse them in one pass. This matches the approach
   used by cyclictest and other tools.

With these changes, all argument formats work correctly:
  -p 100        (short with space)
  -p100         (short without space)
  --period=100  (long with =)
  --period 100  (long with space)

This maintains compatibility with existing usage while enabling the
compact -p100 format that users expect from similar tools.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/src/common.c        |  4 ++
 tools/tracing/rtla/src/timerlat_hist.c | 55 ++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 35e3d3aa922e..c2fd051c562c 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -65,6 +65,10 @@ int getopt_auto(int argc, char **argv, const struct option *long_opts)
 		if (long_opts[i].val < 32 || long_opts[i].val > 127)
 			continue;
 
+		/* Skip digit characters to avoid conflicts with numeric arguments */
+		if (long_opts[i].val >= '0' && long_opts[i].val <= '9')
+			continue;
+
 		if (n + 4 >= sizeof(opts))
 			fatal("optstring buffer overflow");
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 79142af4f566..c0b6d7c30114 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -787,11 +787,24 @@ static struct common_params
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
+			/* Common options */
+			{"cpus",		required_argument,	0, 'c'},
+			{"cgroup",		optional_argument,	0, 'C'},
+			{"debug",		no_argument,		0, 'D'},
+			{"duration",		required_argument,	0, 'd'},
+			{"event",		required_argument,	0, 'e'},
+			/* End common options */
 			{"entries",		required_argument,	0, 'E'},
 			{"help",		no_argument,		0, 'h'},
+			/* Common option */
+			{"house-keeping",	required_argument,	0, 'H'},
+			/* End common option */
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
+			/* Common option */
+			{"priority",		required_argument,	0, 'P'},
+			/* End common option */
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
@@ -819,9 +832,6 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		if (common_parse_options(argc, argv, &params->common))
-			continue;
-
 		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
@@ -850,6 +860,35 @@ static struct common_params
 			    params->common.hist.bucket_size >= 1000000)
 				fatal("Bucket size needs to be > 0 and <= 1000000");
 			break;
+		case 'c':
+			if (parse_cpu_set(optarg, &params->common.monitored_cpus))
+				fatal("Invalid -c cpu list");
+			params->common.cpus = optarg;
+			break;
+		case 'C':
+			params->common.cgroup = 1;
+			params->common.cgroup_name = parse_optional_arg(argc, argv);
+			break;
+		case 'D':
+			config_debug = 1;
+			break;
+		case 'd':
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
+				fatal("Invalid -d duration");
+			break;
+		case 'e':
+			{
+				struct trace_events *tevent;
+				tevent = trace_event_alloc(optarg);
+				if (!tevent)
+					fatal("Error alloc trace event");
+
+				if (params->common.events)
+					tevent->next = params->common.events;
+				params->common.events = tevent;
+			}
+			break;
 		case 'E':
 			params->common.hist.entries = get_llong_from_str(optarg);
 			if (params->common.hist.entries < 10 ||
@@ -860,6 +899,11 @@ static struct common_params
 		case '?':
 			timerlat_hist_usage();
 			break;
+		case 'H':
+			params->common.hk_cpus = 1;
+			if (parse_cpu_set(optarg, &params->common.hk_cpu_set))
+				fatal("Error parsing house keeping CPUs");
+			break;
 		case 'i':
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
@@ -874,6 +918,11 @@ static struct common_params
 			if (params->timerlat_period_us > 1000000)
 				fatal("Period longer than 1 s");
 			break;
+		case 'P':
+			if (parse_prio(optarg, &params->common.sched_param) == -1)
+				fatal("Invalid -P priority");
+			params->common.set_sched = 1;
+			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
 			break;
-- 
2.54.0

