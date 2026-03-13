Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91F382287
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382437; cv=none; b=iQpXHkBqfIMBkfYlbdf+ioX658MBCDjifjwiV2idaAH5omC/mPWxZpZg1sZ/u8/qvvsNBZNibVQ0G8G9/Fs+XW1CjSgASknklOOOQvYeSuucB3xYC47BJbq6fDg6f3ZW7oBifCRQwV83kMYMpBZ2/4OszVi7V8/x/PppbnNVtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382437; c=relaxed/simple;
	bh=+5tIR4frwM4OWqSh/ZYr9ntMYrCrPfvZUQ7q+6ihHq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kzW0MDGa18eF7+ufetKBN0pvh/Iv388fSP0V/TQWP0OUMKQZ5uUOi9/vUN1f81xqtQc5FW/9sqaoEG1cFOu1TTrBUeRq/Y3XxFycDmbPjMBqAORKXjiziVkEaXaFyEtkKR4rUFj08UmEAZPuTwjMAJSsn+1OcgqloUFPp0zcZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhNNSi7C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhNNSi7C"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a0b51eb23so1237791a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382426; x=1773987226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZPV0Jn99UEoemERWZsoqEdi1cZNzUoBuSgEmpyk28=;
        b=mhNNSi7CBBIX/PQzcbWf+ZHobxPfksfV6TOAjfYd1TKQj8zg46zPzGrM9WHyFiq4F7
         UHGOkII3cE9UbNBL3W+z2m8ZcVVevwbSmSzZiALtiAtXBNDM71K+WBC0vIVCOhWJsZSh
         VgKiU4dWVQXRkBSnhsaWoTcVkn2a+6M5tszjlfvhfILRRRKEWyjs+Spss/cLrWb9Q7mH
         52s+UI5YvrpIn2VK63/b0O5zFJtVo6PQJp8ECDuLdLvDGJbmqjNiDGrUlStqr5HKU/Kz
         8TwjcZ9E/mPK4J+E9CrnUbFobBrenxB799/hbMLB9zJ9xGaFbb7H7SC03DD5l490KgiG
         ycPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382426; x=1773987226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZPV0Jn99UEoemERWZsoqEdi1cZNzUoBuSgEmpyk28=;
        b=YXv0bMnmbXgClv7IGkSTPUrPHDKN5vls7GuiKipaBPpUNy1NkbSQESnN9j3tKRewXv
         qauY9ZtNODfQGm2AaCWmDkDv/ghoL3hbIpgo8u7XFVwHarrq/JaeT5TNEiU3cbEX85l2
         2kVb5q/vYdRBN8apN0AxTpqUMF5hJdDSboliarjTMfzVpB68M4okKd4T4zIPVZZGVp0T
         0WZIP+m+aWy3s0AScQJhFFzvLeSm4fZ7jtMC0IyARNBP0J5+JttjwSgOuEpDCMkc4eFf
         YLwxQWRZLNW0Yci71TcsCCGT4hSXAAJ/geTnrhdQkFBwDaKuliIjddlTAVDc+ZeKB4mj
         Fq5g==
X-Forwarded-Encrypted: i=1; AJvYcCXDSpuYEvHStvcjPSx/NnuiMRbbTxGSPaNPPRx/YW0SQuuRwq0WRTSI9E7OMaU1q/+KSVrCU8w5duzcfolDMl+bA3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKn37pMlnROx5aGAulC/fLFdi6+XyX5/qusJXE/c7O5IOoOR0K
	1XAm+JDBQ3ey9Fty4B4asMjgn6cxi4wMOYDGZ3D5BEgHa57DjwYot9O9RQPTTQjbWkrNn0VIeMm
	frBja4zaZnhXoADQ++NDAK4JfGw==
X-Received: from pgbcv10.prod.google.com ([2002:a05:6a02:420a:b0:c70:ab5b:1db4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:648f:b0:38e:95fb:3c8 with SMTP id adf61e73a8af0-398ecda3217mr1744809637.59.1773382426020;
 Thu, 12 Mar 2026 23:13:46 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:14 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=6877;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=+5tIR4frwM4OWqSh/ZYr9ntMYrCrPfvZUQ7q+6ihHq0=; b=VhpH9dBnF58xKb2zfft8mJo46RKUyWcv5dkJyQNNyd+6RD0jDjoe5l1rGJ1S0jPY92ogAmy3m
 J12gExmzbI1BoGEfZ5qQc8Xww9b5V5I84lcrDJ2XdgpCRW8eyhYXL9E
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-35-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 35/43] KVM: selftests: Add script to exercise private_mem_conversions_test
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Add a wrapper script to simplify running the private_mem_conversions_test
with a variety of configurations. Manually invoking the test for all
supported memory backing source types is tedious.

The script automatically detects the availability of 2MB and 1GB hugepages
and builds a list of source types to test. It then iterates through the
list, running the test for each type with both a single memslot and
multiple memslots.

This makes it easier to get comprehensive test coverage across different
memory configurations.

Use python to be able to issue an ioctl to /dev/kvm.

Update .gitignore to allowlist python scripts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/.gitignore             |   1 +
 .../kvm/x86/private_mem_conversions_test.py        | 152 +++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 1d41a046a7bfd..d7e9c1d97e376 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -4,6 +4,7 @@
 !*.c
 !*.h
 !*.S
+!*.py
 !*.sh
 !.gitignore
 !config
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.py b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.py
new file mode 100755
index 0000000000000..17f46c21e85e5
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.py
@@ -0,0 +1,152 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Wrapper script which runs different test setups of
+# private_mem_conversions_test.
+#
+# Copyright (C) 2025, Google LLC.
+
+import os
+import fcntl
+import sys
+import subprocess
+
+
+NUM_VCPUS_TO_TEST = 4
+NUM_MEMSLOTS_TO_TEST = NUM_VCPUS_TO_TEST
+
+# Required pages are based on the test setup in the C code.
+# These static requirements are set to the maximum required for
+# NUM_VCPUS_TO_TEST, over all the hugetlb-related tests
+REQUIRED_NUM_2M_HUGEPAGES = 1024 * NUM_VCPUS_TO_TEST
+REQUIRED_NUM_1G_HUGEPAGES = 2 * NUM_VCPUS_TO_TEST
+
+
+def get_hugepage_count(page_size_kb: int) -> int:
+    """Reads the current number of hugepages available for a given size."""
+    try:
+        path = f"/sys/kernel/mm/hugepages/hugepages-{page_size_kb}kB/nr_hugepages"
+        with open(path, 'r') as f:
+            return int(f.read().strip())
+    except (FileNotFoundError, ValueError):
+        return 0
+
+
+def get_default_hugepage_size_in_kb():
+    """Reads the default hugepage size from /proc/meminfo."""
+    try:
+        with open("/proc/meminfo", 'r') as f:
+            for line in f:
+                if line.startswith("Hugepagesize:"):
+                    parts = line.split()
+                    if len(parts) >= 2 and parts[1].isdigit():
+                        return int(parts[1])
+    except FileNotFoundError:
+        return None
+
+
+def run_tests(executable_path: str, src_type: str, num_memslots: int, num_vcpus: int) -> None:
+    """Runs the test executable with different arguments."""
+    command = [executable_path, "-s", src_type, "-m", str(num_memslots), "-n", str(num_vcpus)]
+    print(" ".join(command))
+    _ = subprocess.run(command, check=True)
+
+
+def kvm_check_cap(capability: int) -> int:
+    KVM_CHECK_EXTENSION = 0xAE03
+    KVM_DEVICE = '/dev/kvm'
+
+    if not os.path.exists(KVM_DEVICE):
+        print(f"Error: KVM device not found at {KVM_DEVICE}. Is the 'kvm' module loaded?")
+        return -1
+
+    try:
+        fd = os.open(KVM_DEVICE, os.O_RDONLY)
+
+        result = fcntl.ioctl(fd, KVM_CHECK_EXTENSION, capability)
+
+        os.close(fd)
+        return result
+    except OSError as e:
+        print(f"Error issuing KVM ioctl on {KVM_DEVICE}: {e}", file=sys.stderr)
+        if fd > 0:
+            os.close(fd)
+        return -1
+
+
+def kvm_has_gmem_attributes() -> bool:
+    KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES = 246
+
+    return kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0
+
+
+def get_backing_source_types() -> list[str]:
+    hugepage_2mb_count = get_hugepage_count(2048)
+    hugepage_2mb_enabled = hugepage_2mb_count >= REQUIRED_NUM_2M_HUGEPAGES
+    hugepage_1gb_count = get_hugepage_count(1048576)
+    hugepage_1gb_enabled = hugepage_1gb_count >= REQUIRED_NUM_1G_HUGEPAGES
+
+    default_hugepage_size_kb = get_default_hugepage_size_in_kb()
+    hugepage_default_enabled = False
+    if default_hugepage_size_kb == 2048:
+        hugepage_default_enabled = hugepage_2mb_enabled
+    elif default_hugepage_size_kb == 1048576:
+        hugepage_default_enabled = hugepage_1gb_enabled
+
+    backing_src_types: list[str] = ["anonymous", "anonymous_thp"]
+
+    if hugepage_default_enabled:
+        backing_src_types.append("anonymous_hugetlb")
+    else:
+        print("skipping anonymous_hugetlb backing source type")
+
+    if hugepage_2mb_enabled:
+        backing_src_types.append("anonymous_hugetlb_2mb")
+    else:
+        print("skipping anonymous_hugetlb_2mb backing source type")
+
+    if hugepage_1gb_enabled:
+        backing_src_types.append("anonymous_hugetlb_1gb")
+    else:
+        print("skipping anonymous_hugetlb_1gb backing source type")
+
+    backing_src_types.append("shmem")
+
+    if hugepage_default_enabled:
+        backing_src_types.append("shared_hugetlb")
+    else:
+        print("skipping shared_hugetlb backing source type")
+
+    return backing_src_types
+
+
+def main():
+    script_dir = os.path.dirname(os.path.abspath(__file__))
+    test_executable = os.path.join(script_dir, "private_mem_conversions_test")
+
+    if not os.path.exists(test_executable):
+        print(f"Error: Test executable not found at '{test_executable}'", file=sys.stderr)
+        sys.exit(1)
+
+    return_code = 0
+
+    backing_src_types = ["shmem"] if kvm_has_gmem_attributes() else get_backing_source_types()
+    try:
+        for i, src_type in enumerate(backing_src_types):
+            if i > 0:
+                print()
+            run_tests(test_executable, src_type, num_memslots=1, num_vcpus=1)
+            run_tests(test_executable, src_type, num_memslots=1, num_vcpus=NUM_VCPUS_TO_TEST)
+            run_tests(test_executable, src_type, num_memslots=NUM_MEMSLOTS_TO_TEST, num_vcpus=NUM_VCPUS_TO_TEST)
+    except subprocess.CalledProcessError as e:
+        print(f"Test failed for source type '{src_type}'. Command: {' '.join(e.cmd)}", file=sys.stderr)
+        return_code = e.returncode
+    except Exception as e:
+        print(f"An unexpected error occurred: {e}", file=sys.stderr)
+        return_code = 1
+
+    sys.exit(return_code)
+
+
+if __name__ == "__main__":
+    main()

-- 
2.53.0.851.ga537e3e6e9-goog

