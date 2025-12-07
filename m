Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0D2EFDB4
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Dec 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765117677; cv=none; b=kcTmuPHO+yExT1A5T13hQ+6mGTGVNqiA+0fQz+JWKVQWaSZ9EbK6KECD/5OsZEC2bMwbXaY5/UrpVlGh41yWEoV73q/xNyllZc2+TwMH502rbnABdc4rnM59QWZQn4jmszBJViiHcfRnLXbZ+eQaeYmh0iG8CSe6jmrN0q48Oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765117677; c=relaxed/simple;
	bh=Kwz/i/ToDupsWxXvYUeC2N41dqM/je07XCbIeJOAi3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BU0oXf3f90GDZlehMba+wUfS+SsSBvwD0O2AcHD5f3oI9JW42/MUU3gM4gKmQwpOhaS+WVMgYwFMGhoLBsv0l8162S1ighgqgi9sUYxeab00E/Syw/YKsfl0FKGHr8MHiY8QSDBLwf2uRqCgLROEPx2MqiBxPVPIIHJ6Yc9HjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXaGq34C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXaGq34C"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aab7623f42so4250443b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Dec 2025 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765117674; x=1765722474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mim4L7D6RiJD0Xfk3ctgRLF/8EuUIkjvDV4bArvMP3Q=;
        b=SXaGq34CXlpeoNBDzbUGPiHuL3CU04HqnpfziHqQ/QjOcq7/gvHhefaZl3ZDVI7Epj
         tXDs2cqvmjv3wKSLum04JL0DJIIaVX9GGBtFrACstU0Xi3q/WsoYGGw8dCwfjhacePJt
         IqvJGleKv+1e4l5BU+wpyx1xgE/KU41BvlSqWmTetvgmw8vtcty4qSWjejJ0cRtNA7np
         W02iVs3p1ZNPKzMXOVw94rqrCyy/5DWWtHgO8Apwvw1CW/ztsPxWS+IItl0L7sM0NSJf
         AIMWKlRMlirZrOD/S3+HSL2VztYH3S8KIoEYLq7aHgID9KEM+JYzY50R6fxNE2Tv+Lto
         sjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765117674; x=1765722474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mim4L7D6RiJD0Xfk3ctgRLF/8EuUIkjvDV4bArvMP3Q=;
        b=YH8QF4v2r1WAOwltk/YJUyYHdjahaEOcJqI8MNcq8VYjUxQcyH7qrufVQfd/YcPtMl
         WwlqMS/ZbVaFVMcQk5yNrOnND0CBOmD8uNg9GzJIYbejSRKNbSQB8xScsvYERFzZAbdP
         eY1FnQyP9wpyjCE3vFzhM6ttPOPG5/2Qmo9mq4Ywbi0iXHvtK82lJf9TYs3E+sJHqYf5
         QFffCDo9koefqChTswg5/irA+B62DFkarlQ3rk1cbl3hBMDohYA8gHi430Qkf/5VxVej
         pN77qVxinePpiprVpyfsMiZYSCHkpbmvqb+xYOkxppPRraCW/RTpkSP21ATfAHBvfE3R
         XSTQ==
X-Gm-Message-State: AOJu0YwmbkAEMurSXK8E3CnhVaWTcz7/08BTRXQKUyZKhGQkvYxLJ0/2
	nF+e4g7B1vQ6AnDrwHrwaTvajCDcMnFAwZt1cOFQc5ffz582Ue5KGOZg
X-Gm-Gg: ASbGncvAka/ZCWydVpo+fSlINaN1NTDIaUv7l8jRgEMolaa0fbtvHIAmOceottW1GG3
	oImmo2SeqTDXqPBR/hShrvxqfZxdvKxjP517nzNGrmh9eLF82zD8vjCj94HxzzwonLGdIkkq/I9
	1qI0pl9YJGQ4vyfWGbmj6PcCIBigTuhQbdGaASk1buuPwoZk7iO2rV6Gh2YDgnjk8Q4BHHCYTTW
	+zskgTcyl+uePP1tc2OOLfxqqRKirI158Wi1wU8TwY9fSvqrFSib465LCluVIoksGrpVpK+7Uil
	chm/tMyFU2RwAC8dqbZAYOGVGUpe+/z2aAK7lwydvrQQrEwLjgeQYf1ScohhPiSPEwGJYSr0h/N
	rnsFSyhp0Mqj3LzpHy7nYmxezxtQab05b/+pd5NdnZknh+dEA71asOQk4lR+YDd4mKeUzRj84gZ
	u2ltQq1Q5YCZIYhjjNBuXbz+MEfJI=
X-Google-Smtp-Source: AGHT+IEVUhB8KEX4xXFxWmTBAiOJNAYgHsDvlU9jrkKUE/cQ/kDX+/4BFflD9NpwiP62P5/AXuU/kQ==
X-Received: by 2002:a05:6a20:3d87:b0:334:8d1f:fa8d with SMTP id adf61e73a8af0-36617e74cfemr4778913637.18.1765117673713;
        Sun, 07 Dec 2025 06:27:53 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686c32deesm9514792a12.13.2025.12.07.06.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 06:27:52 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v1 2/2] tracing: Update funcgraph-retval documentation
Date: Sun,  7 Dec 2025 22:27:42 +0800
Message-Id: <20251207142742.229924-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251207142742.229924-1-dolinux.peng@gmail.com>
References: <20251207142742.229924-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The existing documentation for funcgraph-retval is outdated and partially
incorrect, as it describes limitations that have now been resolved.

Recent changes (e.g., using BTF to obtain function return types) have
addressed key issues:
1. Return values are now printed only for non-void functions.
2. Values are trimmed to the correct width of the return type, avoiding
   garbage data from high bits.

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 Documentation/trace/ftrace.rst | 74 ++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d1f313a5f4ad..de97b65433cc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1454,6 +1454,10 @@ Options for function_graph tracer:
 	printed in hexadecimal format. By default, this option
 	is off.
 
+  funcgraph-retaddr
+	When set, the return address will always be printed.
+	By default, this option is off.
+
   sleep-time
 	When running function graph tracer, to include
 	the time a task schedules out in its function.
@@ -2800,7 +2804,7 @@ It is default disabled.
     0)   2.861 us    |      } /* putname() */
 
 The return value of each traced function can be displayed after
-an equal sign "=". When encountering system call failures, it
+an equal sign "ret =". When encountering system call failures, it
 can be very helpful to quickly locate the function that first
 returns an error code.
 
@@ -2810,16 +2814,16 @@ returns an error code.
   Example with funcgraph-retval::
 
     1)               |    cgroup_migrate() {
-    1)   0.651 us    |      cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
+    1)   0.651 us    |      cgroup_migrate_add_task(); /* ret=0xffff93fcfd346c00 */
     1)               |      cgroup_migrate_execute() {
     1)               |        cpu_cgroup_can_attach() {
     1)               |          cgroup_taskset_first() {
-    1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
-    1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
-    1)   0.380 us    |          sched_rt_can_attach(); /* = 0x0 */
-    1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
-    1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
-    1)   7.143 us    |    } /* cgroup_migrate = -22 */
+    1)   0.732 us    |            cgroup_taskset_next(); /* ret=0xffff93fc8fb20000 */
+    1)   1.232 us    |          } /* cgroup_taskset_first ret=0xffff93fc8fb20000 */
+    1)   0.380 us    |          sched_rt_can_attach(); /* ret=0x0 */
+    1)   2.335 us    |        } /* cpu_cgroup_can_attach ret=-22 */
+    1)   4.369 us    |      } /* cgroup_migrate_execute ret=-22 */
+    1)   7.143 us    |    } /* cgroup_migrate ret=-22 */
 
 The above example shows that the function cpu_cgroup_can_attach
 returned the error code -22 firstly, then we can read the code
@@ -2836,37 +2840,39 @@ printed in hexadecimal format.
   Example with funcgraph-retval-hex::
 
     1)               |      cgroup_migrate() {
-    1)   0.651 us    |        cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
+    1)   0.651 us    |        cgroup_migrate_add_task(); /* ret=0xffff93fcfd346c00 */
     1)               |        cgroup_migrate_execute() {
     1)               |          cpu_cgroup_can_attach() {
     1)               |            cgroup_taskset_first() {
-    1)   0.732 us    |              cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
-    1)   1.232 us    |            } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
-    1)   0.380 us    |            sched_rt_can_attach(); /* = 0x0 */
-    1)   2.335 us    |          } /* cpu_cgroup_can_attach = 0xffffffea */
-    1)   4.369 us    |        } /* cgroup_migrate_execute = 0xffffffea */
+    1)   0.732 us    |              cgroup_taskset_next(); /* ret=0xffff93fc8fb20000 */
+    1)   1.232 us    |            } /* cgroup_taskset_first ret=0xffff93fc8fb20000 */
+    1)   0.380 us    |            sched_rt_can_attach(); /* ret=0x0 */
+    1)   2.335 us    |          } /* cpu_cgroup_can_attach ret=0xffffffea */
+    1)   4.369 us    |        } /* cgroup_migrate_execute ret=0xffffffea */
     1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
 
-At present, there are some limitations when using the funcgraph-retval
-option, and these limitations will be eliminated in the future:
-
-- Even if the function return type is void, a return value will still
-  be printed, and you can just ignore it.
-
-- Even if return values are stored in multiple registers, only the
-  value contained in the first register will be recorded and printed.
-  To illustrate, in the x86 architecture, eax and edx are used to store
-  a 64-bit return value, with the lower 32 bits saved in eax and the
-  upper 32 bits saved in edx. However, only the value stored in eax
-  will be recorded and printed.
-
-- In certain procedure call standards, such as arm64's AAPCS64, when a
-  type is smaller than a GPR, it is the responsibility of the consumer
-  to perform the narrowing, and the upper bits may contain UNKNOWN values.
-  Therefore, it is advisable to check the code for such cases. For instance,
-  when using a u8 in a 64-bit GPR, bits [63:8] may contain arbitrary values,
-  especially when larger types are truncated, whether explicitly or implicitly.
-  Here are some specific cases to illustrate this point:
+Note that there are some limitations when using the funcgraph-retval
+option:
+
+- If CONFIG_DEBUG_INFO_BTF is disabled (n), a return value is printed even for
+  functions with a void return type. When CONFIG_DEBUG_INFO_BTF is enabled (y),
+  the return value is printed only for non-void functions.
+
+- If a return value occupies multiple registers, only the value in the first
+  register is recorded and printed. For example, on the x86 architecture, a
+  64-bit return value is stored across eax (lower 32 bits) and edx (upper 32 bits),
+  but only the contents of eax are captured.
+
+- Under certain procedure-call standards (e.g., arm64's AAPCS64), when the return
+  type is smaller than a general-purpose register (GPR), the caller is responsible
+  for narrowing the value; the upper bits of the register may contain undefined data.
+  For instance, when a u8 is returned in 64-bit GPR, bits [63:8] can hold arbitrary
+  values, especially when larger types are truncated (explicitly or implicitly). It
+  is therefore advisable to inspect the code in such cases. If CONFIG_DEBUG_INFO_BTF
+  is enabled (y), the return value is automatically trimmed to the width of the return
+  type.
+
+  The following examples illustrate the behavior:
 
   **Case One**:
 
-- 
2.34.1

