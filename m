Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4940F755
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728762; cv=none; b=mjo/55y1BggybvUtdCJlMBzt55FgZpjarc/wJ61SQ8svwsDKfEgh6/0PzogYZcSYZ2BRAD64JxubQZuVBcz/oDUFWlaa4xjJzH5gz1VaBf99tMqb1uIpxZrnRHV/rLkLe6mxUwkh3xv/v7cdhZXy+mq/4k5OGBMwV0OlYxv5YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728762; c=relaxed/simple;
	bh=W7TZM8YsaTyi4yFHOv/cXCwdbvYEBMHutHBeAqlrdYc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz2DmYocSeNDLwRrwnCON9utKPVxVeposeYxMMWDhYR/7AR7AthIs70iO5Nemyw8z4+n4pXqYZoZAbGNkGUXYodQ6Qn41OKpX5c27D1rfermpMYJ13qY26N82487KimpW41h3dnrHmAa6W3w5A0BDpmw+I0P98EEtEIoNQJQ5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXO9Jy2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXO9Jy2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784728758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yvq2/LUI55O990FnRryIgjEWaC3axPSi1WaAJCu8gVI=;
	b=MXO9Jy2fhe1e++kkvluHh5sFl4sajXiYUuNFYjkPXltexgN//uiAE8/4/IY9vZLaAIz3ga
	M8JgEtAEAVnO5NttpfSQcii0CWqGwSqMkfvFbGR1m5BNaqpeMp8umMv2I10JiUuIKVy6h6
	BtIA4jQJ3e5eU0PEsGLkkgcwLhNvE+w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-8zoC4-F6PGG74QptXts-Ag-1; Wed, 22 Jul 2026 09:59:15 -0400
X-MC-Unique: 8zoC4-F6PGG74QptXts-Ag-1
X-Mimecast-MFC-AGG-ID: 8zoC4-F6PGG74QptXts-Ag_1784728754
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698ae260973so20713644a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 06:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728754; x=1785333554;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3VCDA5tMhbMqGkiT3tZQaI39OR92357i60g6u0azHCQ=;
        b=S+OZq4q5ey2FfDQ9QaQWPz9dfNt9116Otmpj9C9q8pJ1gejTJC1jQ9LrnAjxYjkERI
         YFYvIIsjqRvzAtsQoyJb8OqLpcSwtO5MyOhrqxhcZeMCVA6I7+PMeePB0SJR2TIrz5x/
         7T4hxYZMMvkTsn+OT4WD+DKD+MkDuKg6FusJDxMGTR+qCSMtc8VuMdW+YoF6yWavCMzV
         0QyuCkd6k+zubyaoXzvW3FcXXjzweCVot4xicCoopoMNozaNohoOzXExRu/50Z1BuFmg
         Tl7Stz3RmuulcuClYeMdKeSGpHSwmYnYY3ATaNR1B7CCbmgr+gYsyMw5kOWKRyHmpp/b
         C5PA==
X-Forwarded-Encrypted: i=1; AHgh+RpqsIfplafwPsqaaJooaispV+gQ89pWdFG2JQqywFcxwNI5uCgWcDTn7mdHAiH4QyNAYWqLbok+5vXNVNi03oikSyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtKaXU/UaVWWofRS8IPz/3TotOzMz+nlJY32JXmlEdT1sV/z2
	k1iaISTUCTwKNge2jKtvFeOXqTCf2gtB4vwQd5CJ8vgzrMZMsWke5SbcYKNkKZNMabCbM/TyuRi
	6/pt6q0TVLqpprm1UFkLQ+9D+HKZFXt9MruJmXP18Ln6EFHCTF8DM/dzS7pxJGgAPxJx43fnB1g
	==
X-Gm-Gg: AR+sD12CJJCNBBKGkKt+vmuJ0Z5iNxWmR2Y6VslYhmaqkl0pfx6bxu6unb7kuAbKFi6
	DA4emTwMeW3rrzraNNmIb/CSaeUKwh+hc8W1XK3u15xof9X6qvlLGBbGZ1C3916/NZOajtO3jHK
	6wb5nRJir+/csl5iWt8aVKqoOGFQrwVO+sWrTKgmeXKVUf5zPHYPW6Fbng1bDQf9Wil7az4bdxe
	HT+XAV5N6mHmr0ENCcS3LT++T7Tb1U/I9ymii/KayBZgBBZlXIOV/PFPtQTBU6mfLl2T5oSMJUc
	4MOChw5mvHcb9HbCOVeTod0T85Bv8iuL/mXD0yvU8dV/CaU59yzWjoxs5vc35RwhuAcDi0jQvXV
	XcFs8kQsyyuh9n+1EJ5XHlUrNG8Y8KPys14XkIGUljdLqVAd7oj9EYJKo3Vgwg9mPyywGKA==
X-Received: by 2002:a05:6402:5055:b0:697:ecb4:b86c with SMTP id 4fb4d7f45d1cf-69e6525aa79mr7563349a12.2.1784728753676;
        Wed, 22 Jul 2026 06:59:13 -0700 (PDT)
X-Received: by 2002:a05:6402:5055:b0:697:ecb4:b86c with SMTP id 4fb4d7f45d1cf-69e6525aa79mr7563343a12.2.1784728753241;
        Wed, 22 Jul 2026 06:59:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f345b1a17sm1079807a12.5.2026.07.22.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:59:12 -0700 (PDT)
Message-ID: <27dcc366f2262becac7a47f93353189fcb9e7b41.camel@redhat.com>
Subject: Re: [PATCH v4 8/8] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 15:59:11 +0200
In-Reply-To: <1aeb814fd0cf348a8cb30cf6c411036aeacc35d9.camel@redhat.com>
References: <cover.1783524627.git.wen.yang@linux.dev>
		 <4eb9a676efe90de8dfc1a9188d6ea81336e65e63.1783524627.git.wen.yang@linux.dev>
	 <1aeb814fd0cf348a8cb30cf6c411036aeacc35d9.camel@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WTg9bl98Z1jLGa-9QI5UFpQGeg_u24LtTVd1Z3ba2zs_1784728754
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-22 at 15:34 +0200, Gabriele Monaco wrote:
> I tried to refactor it to follow more standard selftest building,
> avoiding to maintain things ourselves. The only drawback is that you'd
> have to move the tlob_*.c files to selftests/verification , then we can
> still use RV_BINDIR but support it only via Makefile and
> run_tlob_tests.sh (so let's drop defining it in all tests and save
> inconvenience if things ever change).

I made a mistake in the Makefile (OUTPUT isn't populated before lib.mk),
please find the fixed version attached.

And really, stop skipping the test result if there is a mistake in the
build system, that should be LOUD. I removed all exit_unsupported for
you (as I already mentioned, you can use chrt:program taskset:program
for those instead, all other things are real errors).

From 088d371276d4bdb67d23941e178a351b6afa309a Mon Sep 17 00:00:00 2001
From: Gabriele Monaco <gmonaco@redhat.com>
Date: Wed, 22 Jul 2026 15:29:21 +0200
Subject: [PATCH] selftests/verification: Simplify tlob tests

Squash this with the other patch should you accept it!
Drop nested Makefile in favour of lib.mk and simplify run_tlob_tests

---
 .../testing/selftests/verification/.gitignore |  4 +-
 tools/testing/selftests/verification/Makefile | 18 +----
 .../verification/test.d/tlob/Makefile         | 28 -------
 .../test.d/tlob/run_tlob_tests.sh             | 79 +------------------
 .../verification/test.d/tlob/uprobe_bind.tc   |  5 --
 .../test.d/tlob/uprobe_detail_running.tc      |  5 --
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  5 --
 .../test.d/tlob/uprobe_detail_waiting.tc      | 10 +--
 .../verification/test.d/tlob/uprobe_multi.tc  |  1 -
 .../test.d/tlob/uprobe_violation.tc           |  1 -
 .../verification/{test.d/tlob =3D> }/tlob_sym.c |  0
 .../{test.d/tlob =3D> }/tlob_target.c           |  0
 12 files changed, 9 insertions(+), 147 deletions(-)
 delete mode 100644 tools/testing/selftests/verification/test.d/tlob/Makefi=
le
 rename tools/testing/selftests/verification/{test.d/tlob =3D> }/tlob_sym.c=
 (100%)
 rename tools/testing/selftests/verification/{test.d/tlob =3D> }/tlob_targe=
t.c (100%)

diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testin=
g/selftests/verification/.gitignore
index cbbd03ee16c7..d2f231f1bacb 100644
--- a/tools/testing/selftests/verification/.gitignore
+++ b/tools/testing/selftests/verification/.gitignore
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
-test.d/tlob/tlob_sym
-test.d/tlob/tlob_target
+tlob_sym
+tlob_target
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/=
selftests/verification/Makefile
index 0b32bdfdb8db..aa17478076b1 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -4,22 +4,8 @@ TEST_PROGS :=3D verificationtest-ktap
 TEST_FILES :=3D test.d settings
 EXTRA_CLEAN :=3D $(OUTPUT)/logs/*
=20
-# Subdirectories that provide binaries used by the test runner.
-# Each entry must contain a Makefile that accepts OUTDIR=3D and
-# deposits its binaries there.
-BUILD_SUBDIRS :=3D test.d/tlob
+TEST_GEN_FILES :=3D tlob_sym tlob_target
=20
 include ../lib.mk
=20
-all: $(patsubst %,_build_%,$(BUILD_SUBDIRS))
-
-clean: $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
-
-.PHONY: $(patsubst %,_build_%,$(BUILD_SUBDIRS)) \
-        $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
-
-$(patsubst %,_build_%,$(BUILD_SUBDIRS)): _build_%:
-=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" TOOLS_INCLUDES=3D"$(TOOLS_INCLUDES)"
-
-$(patsubst %,_clean_%,$(BUILD_SUBDIRS)): _clean_%:
-=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" clean
+export RV_BINDIR :=3D $(OUTPUT)
diff --git a/tools/testing/selftests/verification/test.d/tlob/Makefile b/to=
ols/testing/selftests/verification/test.d/tlob/Makefile
deleted file mode 100644
index 05a2d2599c4e..000000000000
--- a/tools/testing/selftests/verification/test.d/tlob/Makefile
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Builds tlob selftest helper binaries in the directory of this Makefile.
-#
-# Invoked by ../../Makefile via BUILD_SUBDIRS; outputs tlob_sym and
-# tlob_target alongside the .tc scripts so they are self-contained.
-
-CFLAGS +=3D $(TOOLS_INCLUDES)
-
-# For standalone execution via vng
-FTRACETEST :=3D ../../../ftrace/ftracetest
-LOGDIR ?=3D ../../logs
-
-.PHONY: all
-all: tlob_sym tlob_target
-
-tlob_sym: tlob_sym.c
-=09$(CC) $(CFLAGS) -o $@ $<
-
-tlob_target: tlob_target.c
-=09$(CC) $(CFLAGS) -o $@ $<
-
-.PHONY: run_tests
-run_tests: all
-=09@./run_tlob_tests.sh
-
-.PHONY: clean
-clean:
-=09$(RM) tlob_sym tlob_target
diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_test=
s.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
index cd949756e713..6bedb1813891 100755
--- a/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
+++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
@@ -2,89 +2,18 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Standalone runner for tlob selftests
-# Usage: ./run_tlob_tests.sh [options]
-#
-# Options:
-#   -v, --verbose    Verbose output
-#   -k, --keep       Keep test logs
-#   -l, --logdir DIR Log directory (default: ../../logs)
-#   -h, --help       Show this help
=20
 set -e
=20
 SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 FTRACETEST=3D"$SCRIPT_DIR/../../../ftrace/ftracetest"
-LOGDIR=3D"$SCRIPT_DIR/../../logs"
-VERBOSE=3D""
-KEEP=3D""
-EXTRA_ARGS=3D""
-
-# Parse arguments
-while [[ $# -gt 0 ]]; do
-    case $1 in
-        -v|--verbose)
-            VERBOSE=3D"-v"
-            shift
-            ;;
-        -k|--keep)
-            KEEP=3D"-k"
-            shift
-            ;;
-        -l|--logdir)
-            LOGDIR=3D"$2"
-            shift 2
-            ;;
-        -h|--help)
-            echo "Usage: $0 [options]"
-            echo ""
-            echo "Options:"
-            echo "  -v, --verbose    Verbose output"
-            echo "  -k, --keep       Keep test logs"
-            echo "  -l, --logdir DIR Log directory (default: ../../logs)"
-            echo "  -h, --help       Show this help"
-            echo ""
-            echo "Examples:"
-            echo "  $0                           # Run all tlob tests"
-            echo "  $0 -v                        # Run with verbose output=
"
-            echo "  $0 -v -l /tmp/tlob-logs      # Custom log directory"
-            echo ""
-            echo "With vng:"
-            echo "  vng -v --rwdir $LOGDIR -- $0"
-            exit 0
-            ;;
-        *)
-            EXTRA_ARGS=3D"$EXTRA_ARGS $1"
-            shift
-            ;;
-    esac
-done
=20
 # Build test helpers
 echo "Building tlob test helpers..."
-make -C "$SCRIPT_DIR" all
-
-# Check ftracetest exists
-if [ ! -x "$FTRACETEST" ]; then
-    echo "Error: $FTRACETEST not found or not executable"
-    echo "Make sure you're running from the correct directory"
-    exit 1
-fi
-
-# Create log directory
-mkdir -p "$LOGDIR"
-
-# Run tests
-echo "Running tlob selftests..."
-echo "Log directory: $LOGDIR"
-echo ""
+make -C "$SCRIPT_DIR/../.." all
=20
 # Export RV_BINDIR so test scripts can find tlob_target and tlob_sym
-export RV_BINDIR=3D"$SCRIPT_DIR"
-
-# Pass the test directory, not individual .tc files
-# ftracetest will discover all .tc files in the directory
-"$FTRACETEST" -K $VERBOSE $KEEP --rv --logdir "$LOGDIR" \
-    "$SCRIPT_DIR" $EXTRA_ARGS
+export RV_BINDIR=3D"$(realpath "$SCRIPT_DIR/../..")"
=20
-echo ""
-echo "Tests completed. Logs saved to: $LOGDIR"
+# Run ftracetest, forwarding all options and passing the test directory
+exec "$FTRACETEST" -K --rv "$SCRIPT_DIR" "$@"
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.t=
c b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
index 4a1c18c7485a..efa4ae47ce72 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
@@ -3,17 +3,12 @@
 # description: Test tlob monitor uprobe binding (visible in monitor file, =
removable, duplicate rejected)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
-[ -x "$UPROBE_TARGET" ] || exit_unsupported
-[ -x "$TLOB_SYM" ]      || exit_unsupported
 TLOB_MONITOR=3Dmonitors/tlob/monitor
=20
 busy_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>/=
dev/null)
 stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_don=
e 2>/dev/null)
-[ -n "$busy_offset" ] || exit_unsupported
-[ -n "$stop_offset" ] || exit_unsupported
=20
 "$UPROBE_TARGET" 30000 &
 busy_pid=3D$!
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail=
_running.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detai=
l_running.tc
index afca157b5ea4..ef53b1b70104 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_runnin=
g.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_runnin=
g.tc
@@ -3,17 +3,12 @@
 # description: Test tlob monitor detail running (running_ns dominates when=
 task busy-spins between probes)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
-[ -x "$UPROBE_TARGET" ] || exit_unsupported
-[ -x "$TLOB_SYM" ]      || exit_unsupported
 TLOB_MONITOR=3Dmonitors/tlob/monitor
=20
 start_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work 2>=
/dev/null)
 stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_busy_work_don=
e 2>/dev/null)
-[ -n "$start_offset" ] || exit_unsupported
-[ -n "$stop_offset" ] || exit_unsupported
=20
 "$UPROBE_TARGET" 5000 &
 busy_pid=3D$!
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail=
_sleeping.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_deta=
il_sleeping.tc
index 0a6470b4cadb..f97e18059e15 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleepi=
ng.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleepi=
ng.tc
@@ -3,17 +3,12 @@
 # description: Test tlob monitor detail sleeping (sleeping_ns dominates wh=
en task blocks between probes)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
-[ -x "$UPROBE_TARGET" ] || exit_unsupported
-[ -x "$TLOB_SYM" ]      || exit_unsupported
 TLOB_MONITOR=3Dmonitors/tlob/monitor
=20
 start_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work 2=
>/dev/null)
 stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_sleep_work_do=
ne 2>/dev/null)
-[ -n "$start_offset" ] || exit_unsupported
-[ -n "$stop_offset" ] || exit_unsupported
=20
 "$UPROBE_TARGET" 5000 sleep &
 busy_pid=3D$!
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail=
_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detai=
l_waiting.tc
index ef22fce700fc..0a5c41e57617 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waitin=
g.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waitin=
g.tc
@@ -1,22 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # description: Test tlob monitor detail waiting (waiting_ns dominates when=
 task is preempted between probes)
-# requires: tlob:monitor
+# requires: tlob:monitor chrt:program taskset:program
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
-[ -x "$UPROBE_TARGET" ] || exit_unsupported
-[ -x "$TLOB_SYM" ]      || exit_unsupported
 TLOB_MONITOR=3Dmonitors/tlob/monitor
=20
-command -v chrt    > /dev/null || exit_unsupported
-command -v taskset > /dev/null || exit_unsupported
-
 start_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_work=
 2>/dev/null)
 stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_work_=
done 2>/dev/null)
-[ -n "$start_offset" ] || exit_unsupported
-[ -n "$stop_offset" ]  || exit_unsupported
=20
 cpu=3D0
=20
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.=
tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
index a798f3e9b3fa..3c606b354ad2 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor multiple uprobe bindings (different offse=
ts fire independently)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violat=
ion.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.=
tc
index 8a94bd679b88..ff8b736932ca 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor budget violation (error_env_tlob and deta=
il_env_tlob fire with correct fields)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c b/=
tools/testing/selftests/verification/tlob_sym.c
similarity index 100%
rename from tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
rename to tools/testing/selftests/verification/tlob_sym.c
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_target.c=
 b/tools/testing/selftests/verification/tlob_target.c
similarity index 100%
rename from tools/testing/selftests/verification/test.d/tlob/tlob_target.c
rename to tools/testing/selftests/verification/tlob_target.c

--=20
2.55.0

