Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681F1474C6;
	Thu, 16 May 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868933; cv=none; b=APOMvhMyHzkW6twalgyU4JxJepqERDNSPrS7if+fsLcdx7E/9JuWwR4oslF8g/jz9txbkP2HZhp2Qm9dt1Mfk7QWbYOZY03BQ2t+5X9IjN9GvHH+KQ0JCqB5Xv9Qggng5bLLm2QCLTxk9SSsMX2k/lSy0xBpR2kijqG/Xu2BxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868933; c=relaxed/simple;
	bh=xJWLHXVj/UusIjMRA+9xpHvtDGqx1XYjqLJwQKL4ogo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSFkz/ZC8YRkn7UbYTOIKjuaK62mnMUN+w3JtQvJ5sosj5Bro/Ztzhx0HqYKDmN9P3zreD218F14e7QkJ/LoBh9u0sUGaSrtRe9G29fGagIlMhSAONdENFEkMxipRv2t1HYnd9+VHZX2shggX1JRKnTU19MPM3CqcxPSIJNgJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCF7Jiok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCF7Jiok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605C0C113CC;
	Thu, 16 May 2024 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715868933;
	bh=xJWLHXVj/UusIjMRA+9xpHvtDGqx1XYjqLJwQKL4ogo=;
	h=From:To:Cc:Subject:Date:From;
	b=fCF7JiokGKzaMT0oqC2YC26FhUVpm4zbfPysWisxdYbvYQBhvbSTTDgQ8CxuxmgeK
	 6Zc4nUSYZHW52vey3c1PIRkW0EtQ7rU7YnPV8wdI9FIhTdC6tjkc4xXg6bBCUKVsGY
	 stWAMpaD56HNDIKHpwEelTf5skswdXqAEZc4VYKDLFxlVpYVJ0H9obOeOtHl+SmR56
	 EfzcKoPP+CswA8mtEwX4rlEKsvNTeT3Hk9R5HxYTEjWs53CUNp4w3EppMyrAyXc4UN
	 AldMTHm1j2QDkcUW3R7qqJzsXWfk+h3b6VzIxbcdR/lLflsKebACBVrHVCqsT/3e0b
	 5nz0B5AMcnXoA==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH V2] rtla: Add --trace-buffer-size option
Date: Thu, 16 May 2024 16:15:22 +0200
Message-ID: <e7c9ca5b3865f28e131a49ec3b984fadf2d056c6.1715860611.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the option allow the users to set a different buffer size for the
trace. For example, in large systems, the user might be interested on
reducing the trace buffer to avoid large tracing files.

The buffer size is specified in kB, and it is only affecting
the tracing instance.

The function trace_set_buffer_size() appears on libtracefs v1.6,
so increase the minimum required version on Makefile.config.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
Changes from V1:
  Increase minimum libtracefs version (jkacur).
  Link: https://lkml.kernel.org/r/0281bfbd3b3fed11a0150a8645a1f9941a423c7a.1713968967.git.bristot@kernel.org

 Documentation/tools/rtla/common_options.rst |  3 +++
 tools/tracing/rtla/Makefile.config          |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 13 ++++++++++++-
 tools/tracing/rtla/src/osnoise_top.c        | 14 +++++++++++++-
 tools/tracing/rtla/src/timerlat_hist.c      | 14 +++++++++++++-
 tools/tracing/rtla/src/timerlat_top.c       | 14 +++++++++++++-
 tools/tracing/rtla/src/trace.c              | 15 +++++++++++++++
 tools/tracing/rtla/src/trace.h              |  1 +
 8 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index a96ea0ed662e..7ac7b7581466 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -54,6 +54,9 @@
 
         After starting the workload, let it run for *s* seconds before starting collecting the data, allowing the system to warm-up. Statistical data generated during warm-up is discarded.
 
+**--trace-buffer-size** *kB*
+        Set the per-cpu trace buffer size in kB for the tracing output.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 6d4ba77847b6..0b7ecfb30d19 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -3,7 +3,7 @@
 STOP_ERROR :=
 
 LIBTRACEEVENT_MIN_VERSION = 1.5
-LIBTRACEFS_MIN_VERSION = 1.3
+LIBTRACEFS_MIN_VERSION = 1.6
 
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index c6100ff46a7f..198a17a3ea2e 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -43,6 +43,7 @@ struct osnoise_hist_params {
 	int			bucket_size;
 	int			entries;
 	int			warmup;
+	int			buffer_size;
 };
 
 struct osnoise_hist_cpu {
@@ -469,6 +470,7 @@ static void osnoise_hist_usage(char *usage)
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
 		"	     --warm-up: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -533,13 +535,14 @@ static struct osnoise_hist_params
 			{"trigger",		required_argument,	0, '4'},
 			{"filter",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
+			{"trace-buffer-size",	required_argument,	0, '7'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -685,6 +688,9 @@ static struct osnoise_hist_params
 		case '6':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '7':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
@@ -891,6 +897,11 @@ int osnoise_hist_main(int argc, char *argv[])
 				goto out_hist;
 		}
 
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_hist;
+		}
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 53a074c1222e..7e5aab22727d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -41,6 +41,7 @@ struct osnoise_top_params {
 	int			cgroup;
 	int			hk_cpus;
 	int			warmup;
+	int			buffer_size;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -309,6 +310,7 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
 		"						       in nanoseconds",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -384,13 +386,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
 			{"warm-up",		required_argument,	0, '2'},
+			{"trace-buffer-size",	required_argument,	0, '3'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -517,6 +520,9 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case '2':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '3':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
 		}
@@ -725,6 +731,12 @@ int osnoise_top_main(int argc, char **argv)
 			if (retval)
 				goto out_top;
 		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_top;
+		}
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6eb6e38d4a05..d4bab86ca1b9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -54,6 +54,7 @@ struct timerlat_hist_params {
 	int			bucket_size;
 	int			entries;
 	int			warmup;
+	int			buffer_size;
 };
 
 struct timerlat_hist_cpu {
@@ -669,6 +670,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -745,13 +747,14 @@ static struct timerlat_hist_params
 			{"no-aa",		no_argument,		0, '9'},
 			{"dump-task",		no_argument,		0, '\1'},
 			{"warm-up",		required_argument,	0, '\2'},
+			{"trace-buffer-size",	required_argument,	0, '\3'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -926,6 +929,9 @@ static struct timerlat_hist_params
 		case '\2':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '\3':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
@@ -1179,6 +1185,12 @@ int timerlat_hist_main(int argc, char *argv[])
 			if (retval)
 				goto out_hist;
 		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_hist;
+		}
 	}
 
 	if (!params->no_aa) {
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 0acfefe151f7..3a23e8d481c6 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -47,6 +47,7 @@ struct timerlat_top_params {
 	int			kernel_workload;
 	int			pretty_output;
 	int			warmup;
+	int			buffer_size;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -479,6 +480,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -k/--kernel-threads: use timerlat kernel-space threads instead of rtla user-space threads",
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
+		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		NULL,
 	};
 
@@ -547,13 +549,14 @@ static struct timerlat_top_params
 			{"dump-tasks",		no_argument,		0, '4'},
 			{"aa-only",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
+			{"trace-buffer-size",	required_argument,	0, '7'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:",
+		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -716,6 +719,9 @@ static struct timerlat_top_params
 		case '6':
 			params->warmup = get_llong_from_str(optarg);
 			break;
+		case '7':
+			params->buffer_size = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -973,6 +979,12 @@ int timerlat_top_main(int argc, char *argv[])
 			if (retval)
 				goto out_top;
 		}
+
+		if (params->buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+			if (retval)
+				goto out_top;
+		}
 	}
 
 	if (!params->no_aa) {
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e1ba6d9f4265..170a706248ab 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -540,3 +540,18 @@ int trace_is_off(struct trace_instance *tool, struct trace_instance *trace)
 
 	return 0;
 }
+
+/*
+ * trace_set_buffer_size - set the per-cpu tracing buffer size.
+ */
+int trace_set_buffer_size(struct trace_instance *trace, int size)
+{
+	int retval;
+
+	debug_msg("Setting trace buffer size to %d Kb\n", size);
+	retval = tracefs_instance_set_buffer_size(trace->inst, size, -1);
+	if (retval)
+		err_msg("Error setting trace buffer size\n");
+
+	return retval;
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 2e9a89a25615..c7c92dc9a18a 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -48,3 +48,4 @@ int trace_events_enable(struct trace_instance *instance,
 int trace_event_add_filter(struct trace_events *event, char *filter);
 int trace_event_add_trigger(struct trace_events *event, char *trigger);
 int trace_is_off(struct trace_instance *tool, struct trace_instance *trace);
+int trace_set_buffer_size(struct trace_instance *trace, int size);
-- 
2.43.0

