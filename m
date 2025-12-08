Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84F30FC1C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199971; cv=none; b=GiLuw2TZwpnIG6B+0ynT4yDbNutrAAZa2139sigqyGcjod0E1otPfFIBTHpQtIwfzhF2KlduSJ9TACo0OJFZB57y1871mKNlD8meMAmpA6YjARUMKPuPy6xUKG0GxyMQhI3lIur2DDCJTQXeeECs26G9+nA0auxtWk0wV0aVpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199971; c=relaxed/simple;
	bh=3bCdGD5FkpIAdYyYC22nZLqB1yqO0XZeOaSMwBTAUTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSGt5i3P8Ii07rQEKzCsDAuFusTmqbbWyHHuwgXQ18bpEAsycRRRkM0MghX49ZzA14oF08b4PJYQIjHntWXRDga4M4CFULY4reuwIErZpeUCzq4OdZFDp2QVSDnGOPmmMKLAjblJ3Z6QvwFUuWfSHforH57/yerqyApGFsUmLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed4Vt3J6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed4Vt3J6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297f35be2ffso67114465ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Dec 2025 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765199968; x=1765804768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkmupKimgD1Rk9p/ZFjo6RNMN1QYMXsx5o4Me/NgHuo=;
        b=ed4Vt3J6gMmWIpkukeIMfwadsJMMf7/dwo02V2JCc2PYRdqDTibqxYprd1cKPFayOx
         9Ud1EM30xR9irRugDd6t6EPvz2el5sLlek22kd8xfmFS/VbN4NGzUbdvVrR0rMKgYRQp
         btc9jCOrIzrDQhlclBa4in4qi98yyqOd9N5+1CfUdge7eYhKrNC0aQR45hmSDNJWY0n9
         4pNyD5ZbLlEn3M3euoQezlAM3sM3cm6jjp4P9yjdofszfDhGpr45prlXCDBc7u1azY7h
         elK/aBEnG8YcqSGaiUrFmzIJ9HnVFGdzk26VRlwiSUa29NdobMF/2b6yof84vtHXOqHF
         R6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765199968; x=1765804768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkmupKimgD1Rk9p/ZFjo6RNMN1QYMXsx5o4Me/NgHuo=;
        b=k+S5QxGTo8cODgZTHH97jhxii66Kp28jc7u4r6xCanYZnSkdjkxykpQOnxKVpZsaP/
         I1SAxb0i5P1C5WsJskVSa4sK0xm0/DgKspoyMxtipRXgrtGVOvOym/W8SsMB1P3wAuQ8
         rjmtdRhA+Rs3mBnHrEd3dXtHdYwsIqg4XAkYSUZG4ksvAbFGVMPsmXUo+rY6I87g8xd0
         8e3QZKx34ZVfxqMkvsRl6bTRYM8zjg+77/NzeJM7G/FYyANFVQZ4TXVJTgGNzYSgRVVv
         mGLM0SUFIQLs+GRQIlShwtfAxtixB6t7qzbgm5Rz+P0YhYEULcoRe32pqG7GPEAmAyZF
         QH6A==
X-Gm-Message-State: AOJu0YwFgrTVHSbsVLbwTJ68E1lvxekgtj8WOojwe50cRPptV6LPDAyl
	d6+pe6VKnNz+49O3/DYm/4LCBQdi7torhWE1rWgVgVMPbSV47EfbAYIo
X-Gm-Gg: ASbGncu5m5hYmi0E3ANy3KPTV6e2tO3+LS7DR1ASHGf4SaOIjtTH7Dk8W6KxtUeszkU
	nsH6CubbNWKfJwApCXzkSCpaLo/98jUCK+ZK1vShzU0LAMpfunqvaNUyn+bNSKHrpkAN3j3YgSg
	2OyR31fXTnBdE+zjV1iSX8GCR04q2ZqUmhAes42nOy08tH23JVMGUuPqcrhfJXgisjRjw+JJuRW
	b5vjvgz/nZQZPKsA2N+pPNJXsx/pKuNsNQqstS5MzItXr8F67+sE1LCBNID8TYzq5P7M6aDQiPE
	Di9UVXmETAzhOUDyRjT6uAUJSJ/+6YWiJwNk9BO9KINHFvU3STGawNH0GNEw4GWhOwXVVHocn/d
	5SEt7M1ZdJPZhhoZFzwjhT/0sPRUEGYdIRBL9fRWZhu+MAvJdHywhcxOFJ1Q/rJO9fpH5wYW4xV
	tTnlpeBI7iYP6x6KbfU8JYkzbLbkq6174RuLtL5g==
X-Google-Smtp-Source: AGHT+IGvWbkfyWsvDaD8zDVwbf1HrBIDdnuUuIME9a6jI1GzdIehLaH75wd1F0bqZJ8oibOKcUA1vQ==
X-Received: by 2002:a17:902:d509:b0:295:2276:6704 with SMTP id d9443c01a7336-29df5deb71amr53107855ad.51.1765199968563;
        Mon, 08 Dec 2025 05:19:28 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaaba21sm126848595ad.70.2025.12.08.05.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 05:19:27 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v2 2/2] tracing: Update funcgraph-retval documentation
Date: Mon,  8 Dec 2025 21:19:17 +0800
Message-Id: <20251208131917.2444620-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208131917.2444620-1-dolinux.peng@gmail.com>
References: <20251208131917.2444620-1-dolinux.peng@gmail.com>
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
 Documentation/trace/ftrace.rst | 76 +++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d1f313a5f4ad..d2edd58f04c3 100644
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
+Note that there are some limitations when using the funcgraph-retval
+option:
+
+- If CONFIG_DEBUG_INFO_BTF is disabled (n), a return value is printed even for
+  functions with a void return type. When CONFIG_DEBUG_INFO_BTF is enabled (y),
+  the return value is printed only for non-void functions.
 
-- Even if the function return type is void, a return value will still
-  be printed, and you can just ignore it.
+- If a return value occupies multiple registers, only the value in the first
+  register is recorded and printed. For example, on the x86 architecture, a
+  64-bit return value is stored across eax (lower 32 bits) and edx (upper 32 bits),
+  but only the contents of eax are captured.
 
-- Even if return values are stored in multiple registers, only the
-  value contained in the first register will be recorded and printed.
-  To illustrate, in the x86 architecture, eax and edx are used to store
-  a 64-bit return value, with the lower 32 bits saved in eax and the
-  upper 32 bits saved in edx. However, only the value stored in eax
-  will be recorded and printed.
+- Under certain procedure-call standards (e.g., arm64's AAPCS64), when the return
+  type is smaller than a general-purpose register (GPR), the caller is responsible
+  for narrowing the value; the upper bits of the register may contain undefined data.
+  For instance, when a u8 is returned in 64-bit GPR, bits [63:8] can hold arbitrary
+  values, especially when larger types are truncated (explicitly or implicitly). It
+  is therefore advisable to inspect the code in such cases. If CONFIG_DEBUG_INFO_BTF
+  is enabled (y), the return value is automatically trimmed to the width of the return
+  type.
 
-- In certain procedure call standards, such as arm64's AAPCS64, when a
-  type is smaller than a GPR, it is the responsibility of the consumer
-  to perform the narrowing, and the upper bits may contain UNKNOWN values.
-  Therefore, it is advisable to check the code for such cases. For instance,
-  when using a u8 in a 64-bit GPR, bits [63:8] may contain arbitrary values,
-  especially when larger types are truncated, whether explicitly or implicitly.
-  Here are some specific cases to illustrate this point:
+  The following examples illustrate the behavior:
 
   **Case One**:
 
@@ -2885,7 +2891,9 @@ option, and these limitations will be eliminated in the future:
 		RET
 
   If you pass 0x123456789abcdef to this function and want to narrow it,
-  it may be recorded as 0x123456789abcdef instead of 0xef.
+  it may be recorded as 0x123456789abcdef instead of 0xef. When
+  CONFIG_DEBUG_INFO_BTF is enabled, the value will be correctly truncated
+  to 0xef based on the size constraints of the u8 type.
 
   **Case Two**:
 
@@ -2910,7 +2918,9 @@ option, and these limitations will be eliminated in the future:
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

