Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF704FDE5A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565563; cv=none; b=GK3TtLHGVE88KP1h4s0z17HRGyo4SGYqGYh7N4+hW66zUaeg1US0hr+Zkm5c2vo+JrAZkQPP8dFJSY1+obFHrjmcVQlp3775lF/V1/cRi7aZicTeqMUgDJjSdcZXhrc3dpA/YSkC/M77sgdGQSPkmzAlIsjrSlJcKfFwvSZqyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565563; c=relaxed/simple;
	bh=ntRH15t4Lvt22zdvEstGdhxFnzUJuuJOBEZqDNUl1wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LsleclYwImvoJ2JrDsg5sx2jXS570PCoGaR5qPldPgGvuFUyxPxANpGqKTDSoN5piuhfF2O/j0vGvOJsFdpamj49+2muGculhMqVyR73oRg6UKc67aWz2STLNdlDtvaR659vlmcVf2angFevSNjPaEX85PNviZWD3eK5cx1BJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArIcPp5X; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArIcPp5X"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so556182a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565555; x=1790170355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4l3Wyd9thJNNsaD9/92h5owhyhVWLhgVC84mljLruBo=;
        b=ArIcPp5X+cwASztbnIMjMGVsyQ5QnX4xs5JSbQyeDgarT/CkoSIMahGssF1Oo1pPCf
         EI/HTcvm1jaSWzeBNmY9RwrfeD1eKoKW36ezTzBW9AbsRuoJt9DMymrdixPvjDxxtOFy
         zbURPAcF/GweGLdkKJOkc4WSK08oRwd7BlaXjxYJapMXLQQq9BzIGAFB2GnBYzXpBAlF
         KTzA1VUB3k1G1lMNnK65zL6N/OM0GDdEFIxLtZR+EGdHMAzLfinrIwLGAM1Kg7HQ33g2
         N9xFZpyWg63BnwKKcrH5nYkmbjXp2XfNiD76fn0cIXCj/9XrW/RsrDDHdvWFb2F3h8rc
         y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565555; x=1790170355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4l3Wyd9thJNNsaD9/92h5owhyhVWLhgVC84mljLruBo=;
        b=hM+F845OsxZJZ2PGPr16ZO7OTUJwOHrRvBsRf/c3fwPWPMXz9SvBLtXmvhzVqPP7ui
         sWDBrr8Te8O+pIEF/Bv+k+I8rl36XFVM5a/MOYFxSapVB5J3otvgtdjoT5Io6lh36zZr
         yyD4tamRt+kNoOox48SDlpuHt5dwF1Aw3/IxAG4yCKXTOJY4TCKS33sjMxFNKzgh9PbG
         E2H2JYv9iH/ZZoe+s5WvUpir8WGQ9hMJAOwgGMr04xzJcrzr43LwG7SfDHVjWuF1lkRL
         mhUTlxPYEJcA1KEzM895zvQdrUzMLx/c1t3Dpym4F48iMjgRO3kALq+lA3MRu0yE0Pr4
         HaYw==
X-Forwarded-Encrypted: i=1; AKwUvBw2e2wvkm9WWnSzSuvnz7xXhz/Mk7EwvmLuD3GAyOLmoQRv2CrexNy8ymd0ZEFn6PK9WRlqbJD/QnFkiTTucRMVbsU=@vger.kernel.org
X-Gm-Message-State: AFuF++mz6pHTDMNfuNlKP09KDkOqym7wkqqNDQ4xJmGbWbaUe2iHE4Mi
	TfT2Lk4zUfh5lfo7GDDLpHIibWiub5JWYCe/+8RoQXKQBuunhz3ZPFsU1aTl4lreQNo=
X-Gm-Gg: AYBFou278d4wk7xFZFR/P2ssmuSC95Cy8Vz73WQTSjFJNyb2fiRN3enifvjPMN+wXGX
	8PaN2dHkdP6NlC0VrhGgsLczhhKf27CDo24GSb4tj3XAm7Enicv9goKhcDHGPShKBbAOwhjtWzk
	g4Ish+Nsajfw/px9NTXXXIIoEuI5aNYeCx3R2qN/MZ7XyfeNpp4OyOQBaCUC+IXNquQgCtyW+y4
	P2boqdohGX4qZJgWkHDGI2vTH8WcdYTiB9cxgBrDfTQqVZPYFueFStiF0gyS0ERMtwabAvv79B3
	nFPcLZdMW2LxwMAdoshnH8+OODB0K64PjjGPGKE2qU5Y0I4EHDzFvDLdXVWi5qOR2PGcjQVZiHV
	By8HvANxIkhJoPH9TvmE4xkQx7i2BFHwTuzua4eReojLt3WvErsVybzUx5yrdKgk5AG0cz68Jke
	FWgZ8jDreRv0oUtM3VXNVKYNQotQnmGiMhIpV10DH3jFobIDwJA7v+GHPVIoHZkjorTFaeIXulT
	IWCt2/CB5pyxJe8PgItuvBr9w==
X-Received: by 2002:a05:6a21:4d0c:b0:3d3:b00a:6f03 with SMTP id adf61e73a8af0-3dd5f7dac4dmr7049928637.28.1789565555369;
        Wed, 16 Sep 2026 06:32:35 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm1651702a12.20.2026.09.16.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:34 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v6 4/4] tracing: Update funcgraph-retval documentation
Date: Wed, 16 Sep 2026 21:32:18 +0800
Message-Id: <20260916133218.1282590-5-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916133218.1282590-1-dolinux.peng@gmail.com>
References: <20260916133218.1282590-1-dolinux.peng@gmail.com>
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
 Documentation/trace/ftrace.rst | 96 ++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7261f25f8b4b..9423722848c6 100644
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
@@ -2859,43 +2863,55 @@ be displayed in a smart way. Specifically, if it is an error code,
 it will be printed in signed decimal format, otherwise it will
 printed in hexadecimal format.
 
+When CONFIG_DEBUG_INFO_BTF is enabled, the smart format also takes the
+declared return type into account. Signed integer and signed enum return
+values are printed in signed decimal format, unsigned enum return values
+are printed in unsigned decimal format, and unsigned integer, pointer, and
+aggregate return values are printed in hexadecimal format. Boolean return
+values are printed as ``true`` or ``false``. If the BTF type is unavailable,
+the legacy error-code detection is used.
+
 	- smart: echo nofuncgraph-retval-hex > trace_options
 	- hexadecimal: echo funcgraph-retval-hex > trace_options
 
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
 
@@ -2914,7 +2930,9 @@ option, and these limitations will be eliminated in the future:
 		RET
 
   If you pass 0x123456789abcdef to this function and want to narrow it,
-  it may be recorded as 0x123456789abcdef instead of 0xef.
+  it may be recorded as 0x123456789abcdef instead of 0xef. When
+  CONFIG_DEBUG_INFO_BTF is enabled, the value will be correctly truncated
+  to 0xef based on the size constraints of the u8 type.
 
   **Case Two**:
 
@@ -2939,7 +2957,9 @@ option, and these limitations will be eliminated in the future:
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

