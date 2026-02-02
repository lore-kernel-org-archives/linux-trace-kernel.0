Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38931399029
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071481; cv=none; b=Sdlrx9mWeikwUlzUEIFRA27kkUGN6rsX3z0ieSiUlYwDtnRt31yJbFjLnav9U7ILdA8QJVmVuIV8qwSckYyrX66Uw1Y2D+SNG7YxzakjwP1q5ZG29M0sSuN616ndquM/VqkmtzaJDv0E1EJSptlV4qt6bGdcshy4KCmK4qgmkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071481; c=relaxed/simple;
	bh=2WTkW1ohNlyry4byAU9mrt/4FbKH8bSD8cCbQ3cjXxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h8QbnMEuGRFRR2fzCrsai5V1PqS8FAPpjfDNmsKvANHhnuWIpoH7T041ySxVKhY4ZB/PRMnwFxE3TIJ4YCyHOdOZu+b0jqUh/ObT+jW6HISTDN6g/AwvxnQeW2A6g3Y2kL+uUW4pNYXjfZp9yjYCYpgiGM7s0vjtOhhHqjeI/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyQC1XeD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyQC1XeD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a0a4b748a0so105182215ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071479; x=1770676279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zg+HE16wd7vn5dsGeMXGIm23bEFage9ublA+Ui2LaW4=;
        b=HyQC1XeDAoIVL3wO23S9xpf3Mi+BVLJwE2K1H+fNMXfwKBegO8ZeuTKPHGtldeAy/+
         xlYgsg2oS1YL9awM04wJ6HXQdNo0cq9Hgc8Vr5ND4c3bGZbH4CzM5UiddggHzca1kI7W
         lxBcO7l8qeJiT8EFwq8Q/L74FmKJ5yzyP8Pwvcwdsx/rgvz2IJ0XiCuPT4lFdWGTAs8V
         WeeX0TUSl7yz9kmlNpkX3PXDdL0aqsx1mNXVgiY4m1BtOlc7EvRprLmJVIP6maCE+KeB
         YT3UYO2G/l4tmtGxOEwK6WA9CI4/jkgzRsV0bLpPPUFAr0PtVuBRqEChsC71Gz8HMAtF
         Ebkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071479; x=1770676279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zg+HE16wd7vn5dsGeMXGIm23bEFage9ublA+Ui2LaW4=;
        b=KmOEFvZ7UKriUx1lpxUof4VPqczfFoMv6N2Xe3USE8WOWVD4bpGdLUOXRdBBx3Q/Se
         hg2Gn5w8qTGcRXf+qFZwi2fs+UKotqzspSrzJJZ/Yn/Wv/OD10c5rFJmm08h/0qYSo0T
         T3pIR+YluX+T3ughQk2NhoK8JbZhvuTdPf73+l1Pd3HD/eJQhBfsOlu2BEQ9TLx0o5tx
         bNbJ6SBd1DGwpoXaSHr/k4Gj0POnZEP4XatbAfs1Zjbi+WySyMKcCy+yfk1H/OYvAajH
         u968XM6d/pHpwBqrgyxLYaM38paEq2YV0i2CdHHtJIondE3WsUbb85fWplXKTYtwsmpp
         5Geg==
X-Forwarded-Encrypted: i=1; AJvYcCVhXpqSm4gymard0lbPlb4ZAAHePdwVqDg7o/QRzYUPd8Qa3qtoWYfxMXdwIfvA9yP1eV0aBUwQfyuF5L3n516AGvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUaLMolThL7OZEv72iRH3sW1Q+lmsws691gh+j+TZv0/A+UrYz
	pOLrlKyRR33wB9oGcOxF6xg0Mt8L2LtmB2wqTvPOtQXPrvEu2dq8rnGFhsCjeFT0y0mIjgq2yw+
	m1Zfp50gvCe23cLvHINuc/N0rqg==
X-Received: from plbkg6.prod.google.com ([2002:a17:903:606:b0:2a3:2b32:4916])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2c5:b0:2a9:410:23f6 with SMTP id d9443c01a7336-2a9041026f0mr68971965ad.41.1770071479409;
 Mon, 02 Feb 2026 14:31:19 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:13 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <b258770e0cc153b3313c348b7110d5998cbec7af.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 35/37] KVM: selftests: Add script to exercise private_mem_conversions_test
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

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
 tools/testing/selftests/kvm/.gitignore        |   1 +
 .../kvm/x86/private_mem_conversions_test.py   | 152 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100755 tools/testing/selftests/kvm/x86/private_mem_conversions_test.py

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 1d41a046a7bf..d7e9c1d97e37 100644
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
index 000000000000..17f46c21e85e
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
2.53.0.rc1.225.gd81095ad13-goog

