Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154147F77A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270384; cv=none; b=gAatJ2DxRTyazn9oXgU6vMCMaOC63h9MpBUn0vufEMxtAnCQbtwSzJ/dRV7rbtciOyJlfYxxD6+uJ0UVMiSkLBOOif9xliUBM0hY+tCZyYts9FJktt3Ihxr3O7fxlsKd+CCuqfKNfcA8/jwh9EkP9Zno/sSTJx182yB40+mbZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270384; c=relaxed/simple;
	bh=Dr1eFYf0KAOq3d4noAOFx4h+3dYSj5kdLG8+hPm06U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLQohgThTZFx3STB3KYUl2sAlC+IaetyEzBlMxpD02u4j50R9S2XeaWK+2Y3c2v326vrcBF5eJaR50T6/SWpRS/3MtQKX19mrnZTwuP37KBzvcyCFJlX9DHSfFvfE7WLqFKIgkaNkofmnlMdqxpS0iuSG+0TKQ/vj8y2uE+9QyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNP3qjVj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNP3qjVj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8541875f596so2620997b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270382; x=1788875182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FDTK3zfJKeOHQ/kUEowX8lWsllkazH/BKZLeMUQjwCQ=;
        b=rNP3qjVjLYOmqhDyaNIy/7xn/adqumZXSEO+ADZBeYMudNITt6O03VwC3/tBMzbbf0
         p5LZk7C4FT4ldgFToRNVJ4MN+oHtUROn8sFeiUJwtX4lhkyGFb4c73jdnzP4oowMN2aO
         v451jIGSaUmC/vm970rx5SiXO7LicpyPKaE0xOCFZ5ei46prjq9anxt9ehBKPv539/kD
         iqADRlPMF8OE8gYLRzN4ROuDgrBO4iBR0h0ESgHQzytJwitUl1vKSTKvMHDkdLIN0D50
         kR0bDLKJsxlhieIgJBB99Fnp9S/+pdgSvcc/AsyXcl1CIWwvLs3fbwVn6FnEVJ1rnPd7
         0I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270382; x=1788875182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FDTK3zfJKeOHQ/kUEowX8lWsllkazH/BKZLeMUQjwCQ=;
        b=cwNaYOuk7jjNCUEGLvpxf1kBLlTdFK4ctHoc65RHpW/7cR0wkMgqR8koyvRiSAQX3n
         VzGR45qgnXNBjh82m6MzTm3cVcXFZXi8kKg3az/TP4zcVaoKOmhtQc/3s4QvpyDgisjl
         1Ok7Zl0wJk1UGeSmbk5XmuIAiXiTysFAXl7LXnPonLfUoGxd779ys/s0z6/sxA2hvNTE
         Bm7CH1/nRSAMgXUeJ6dyfHGqFvtrJMFmXQvas3SQrCnC8CUoYYzjchDpM6HYx1Q+h5X8
         6ojnMCT3WT/Nul2wCS5apwWRPbz/JP5smwIsFanCvSB3RILUtzU6b9haujahBNTsU5nw
         DxLw==
X-Forwarded-Encrypted: i=1; AHgh+Rrr0fjz6rKdeI7G5qzqVmayIS1F//PtKJmokLSiUUg0s6+8ppBvYaDeCB4z9Qeq7CI/vkk8kFu/XFZ/SGF09xI/k34=@vger.kernel.org
X-Gm-Message-State: AFuF++kadlTkOHoecONG9718PlNPIVNNktQzYOa77O73AsuYtlO93ykH
	V+nTt05hyfnqRQdKVLEynKG1w5yJ143lvwmrg/JzsvfmGd5B0WlVvkxQ
X-Gm-Gg: AR+sD10xyF3DLJYht5wZ2DXVzl5O3hmBPtxw6xUzF7i4PR1F6/fmeSOOo+mzxRdhMZ9
	XEZqIE67iqDFxLL03zezG2/SH71oR4vFceSf7/Ebtk7LcZnF/ZriSG8b7RL62YdulqCwIBGKHqI
	MKkHNdtBArKk7AA0AYGTQUzq6tIVqCfwbvKeBXDpSjbWAyGJj/XmMElQF41rOp2r8v8gjsDrJrH
	12hqJkBLCaVZGoGh3ApF+l8uaoOHg8tsXmzRJpBTDWHMwZInVeASwnwkxcjqj6w8XiTIoLX8wMf
	6GmXhVej5eDkmA22cMO09b4JXzhSOT3a5qRpbGCmQNB/bJ4FnDQjzh+xuAFpXOArVRSNRhCba7D
	UlxSuTNPcmCPRPTjsvAiF0V0vownoFUIXmVg8VSpeUdFsPneSacXv6qe9P9rxV5DJwIXbYQlMj2
	375gNl+KmoJ1rzEEEdx0613KEIdGo12ep1h1uWjyz3N57zT1rCQ4g/EDz7d7+8LDzNJbwSZit5l
	27v0HmNBVb+QGM=
X-Received: by 2002:a05:6a00:8015:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-8562b499a0dmr53844448b3a.10.1788270381890;
        Tue, 01 Sep 2026 06:46:21 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be8f52cb4sm1132502b3a.39.2026.09.01.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:46:21 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v5 3/3] tracing: Update funcgraph-retval documentation
Date: Tue,  1 Sep 2026 21:46:04 +0800
Message-Id: <20260901134604.4052265-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901134604.4052265-1-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
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
 Documentation/trace/ftrace.rst | 88 +++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7261f25f8b4b..696bfbede590 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1483,6 +1483,10 @@ Options for function_graph tracer:
 	printed in hexadecimal format. By default, this option
 	is off.
 
+  funcgraph-retaddr
+	When set, the return address will always be printed.
+	By default, this option is off.
+
   sleep-time
 	When running function graph tracer, to include
 	the time a task schedules out in its function.
@@ -2829,7 +2833,7 @@ It is default disabled.
     0)   2.861 us    |      } /* putname() */
 
 The return value of each traced function can be displayed after
-an equal sign "=". When encountering system call failures, it
+an equal sign "ret=". When encountering system call failures, it
 can be very helpful to quickly locate the function that first
 returns an error code.
 
@@ -2839,16 +2843,16 @@ returns an error code.
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
@@ -2865,37 +2869,41 @@ printed in hexadecimal format.
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
-    1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
-
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
+    1)   0.732 us    |              cgroup_taskset_next(); /* ret=0xffff93fc8fb20000 */
+    1)   1.232 us    |            } /* cgroup_taskset_first ret=0xffff93fc8fb20000 */
+    1)   0.380 us    |            sched_rt_can_attach(); /* ret=0x0 */
+    1)   2.335 us    |          } /* cpu_cgroup_can_attach ret=0xffffffea */
+    1)   4.369 us    |        } /* cgroup_migrate_execute ret=0xffffffea */
+    1)   7.143 us    |      } /* cgroup_migrate ret=0xffffffea */
+
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
+  but only the contents of eax are captured. If CONFIG_DEBUG_INFO_BTF is enabled,
+  the suffix "(trunc)" is appended to the printed value to indicate that the
+  output may be truncated because high-order register contents are omitted.
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
 
@@ -2914,7 +2922,9 @@ option, and these limitations will be eliminated in the future:
 		RET
 
   If you pass 0x123456789abcdef to this function and want to narrow it,
-  it may be recorded as 0x123456789abcdef instead of 0xef.
+  it may be recorded as 0x123456789abcdef instead of 0xef. When
+  CONFIG_DEBUG_INFO_BTF is enabled, the value will be correctly truncated
+  to 0xef based on the size constraints of the u8 type.
 
   **Case Two**:
 
@@ -2939,7 +2949,9 @@ option, and these limitations will be eliminated in the future:
 		RET
 
   When passing 0x2_0000_0000 to it, the return value may be recorded as
-  0x2_0000_0000 instead of 0.
+  0x2_0000_0000 instead of 0. When CONFIG_DEBUG_INFO_BTF is enabled, the
+  value will be correctly truncated to 0 based on the size constraints of
+  the int type.
 
 You can put some comments on specific functions by using
 trace_printk() For example, if you want to put a comment inside
-- 
2.34.1

