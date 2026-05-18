Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289B377EAF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117832; cv=none; b=pOEvfRiQwk+JHgMq6SWZYzrQzQmc0z+puHBwuniuBkbZxGhnLx6lseLuC3EBNgjpuKmjyQ11xU+GnKMmYCTfQJXwBlrOgjdjozQ7hfJfZB90UT3Vb5VTU+IqhY7djJbu3I9bGqq+8XtPT8PowL/he8BQV9bAT0RfGHt4Jo8nOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117832; c=relaxed/simple;
	bh=JWnfkRj7acypCRgQ2P3N5GkPCBgIa6ihDg7aONdlJeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnF2d6NeDkObEMg1YWnlGdtLN8TtoF2qA5mN7l19KSttLhdfLpHCBINAv58F+d1wCzeMuvL+TK9ANVrWg7Og4Y1G1h/Yn/EaAnJp0JmzX2jd10el/Udw7EOXROOI6qkYckbW+tYJfRcmGsGYtjdLETsc2cFffOXOgmkJjtuNLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KljCT0aC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KljCT0aC"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso4038214a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117829; x=1779722629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jfecon1+FJouMr7NxpfhMU7AiOyZ4t581UhDPjWKcQc=;
        b=KljCT0aCiOfl44C5ptct4fQ9qv4lTB1OO6hhR93P3UhpT4QTIIkquHUGQycE28VkFX
         9VEgyeVj4fN8YbPHgxydD5q1NZyncV8J4V4v5j6hjEq4xyxnd1atnb9jzlwE/Pq/MNg1
         6sJXhKsm4I/Wzcw8gV45Y4S+UXrr7C4xJdkdqD9Nj/KI1cSVFf4NfW2hoA0XMi+iERVO
         jeCBoZ2hgiTZuBMwPCzm5qJNQKtJmnEjoz4OSjLJ0BrqgapLzChyxzZmpxvLyN5w432a
         hNCPNSnnqik+4xwgPUNSlnFp1mdgQISScCK57W6G69TpWtOHNM35Il9ubSr/9lm2tAh4
         cKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117829; x=1779722629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jfecon1+FJouMr7NxpfhMU7AiOyZ4t581UhDPjWKcQc=;
        b=mglQ4o31K4yFtbH4VNm3lWPhiwPuI/P13TNKqjS4kDzFSAF+WHxL7Ll7fCEZeA3Wi0
         JdeGLldcIRxhOZ+17lq7Plb1/VE1bvafi7B+fqQdpY9oB3Pl7sh8gcDq5n/01dBal6lC
         Wg3fq3iXfDokOLSBr14FP6DNrO2Cr4yWjB6we8iJZge7KK7feURa16dGZge7BBk3Z0c/
         T0NFLkMgoL+eZCCyuDJhePaOdJ9FF6gEQmyi3qGqLzNscOSAxj2CGRMyahd6DrFlJhig
         yAvwHXTXuQwrhQBQbcy8/5ROmIoStsMp9/cokdUwjqAAcdsvztpyuScBb4F5IM6mMbnb
         zvLw==
X-Forwarded-Encrypted: i=1; AFNElJ+PZ28QqxAGXuIGYBg2n44bn/yPIlZ5ydcaTnN+K8y2nuRjZ8lC/3AOMwLFs6WHGOVEsKYktXPVcqOmb1AUjs7GaP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmp4URDRR13WKLCBjg+kwD+kUTYTjXtXAL1LeViWRO0Iv7b85y
	LuyZTFp0JFSD92/PLmrFiuTcm9wH0HtAtEdet/I4wyRAqJzFT/gkuq35
X-Gm-Gg: Acq92OHFrkakxtm2qtN+7Bc8OZneyav5X38dhfBSNhD6AKGSdJJcS7f776Ul9jthMyJ
	yvpYPyOw8Usc3Mjik105kEHdGn6qgeeNGn5W7GDQPGRZXZgY3rzpF6ymyGTpd2CKnsuxE1XkNI1
	pRipQCkT+VDvKbNpuVE+sS4+Bi1TuxEtYe0OhUeXXhmwAA+7iXK6FIjwE1Lr+3zisUke85Kj/BQ
	N9NvVhLGbTKKHzlV+iqWnqpZEDF/bhA8Clf+mPqHDEHdPtLOCpmRlGxMrT00pUsaHDdi4ZcJNRU
	WjN+uoioNX1PJtTKhM9aQJvHcULqniE4pobZG/+d6Scgrcs1YcqorLSn92kaYsf0gB9xyVEkaFV
	i84g91XS6SOmKGSIwhgK8aStFiJpRsNAVuOyDioU50qzGH8/HArFhtL0Ui8OheC5q8X+r7hCpOl
	VcfnrzCibtZqKDbw==
X-Received: by 2002:a05:6402:1945:b0:67c:a6d1:c48b with SMTP id 4fb4d7f45d1cf-683bc8ac76dmr7075011a12.11.1779117829305;
        Mon, 18 May 2026 08:23:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d510fasm5402669a12.11.2026.05.18.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:23:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 18 May 2026 08:23:17 -0700
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add test for tracepoint
 btf_ids tracefs file
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-generic_tracepoint-v2-3-b755a5cf67bb@meta.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
In-Reply-To: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779117822; l=4942;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=vclZkPuWenN7wMDirKYWTTYHLEsDjraiMxch1UNCmV8=;
 b=bshb2F7IT4OVbQohWyRg8xxKOs0RG79TDSCfWA4ZFmVAyV1gpgVor1q28xCF7iU8MgeL13zv9
 LgKbsv1FatjAW5YKc8PZ8ln9KEt8fRh9Ra2RKg+LQasa9bumsHOT5g7
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Read events/bpf_testmod/bpf_testmod_test_read/btf_ids and verify the
exported FUNC_PROTO matches the testmod tracepoint signature
(__data, struct task_struct *task, struct bpf_testmod_test_read_ctx
*ctx) and the record struct trace_event_raw_bpf_testmod_test_read
carries the fields declared by TP_STRUCT__entry.

Use the testmod tracepoint so the test exercises the module/split-BTF
path (btf_relocate_id) rather than vmlinux only, and falls back from
/sys/kernel/tracing to /sys/kernel/debug/tracing when tracefs is not
mounted at the new location.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/tp_btf_ids.c  | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
new file mode 100644
index 000000000000..c0e7e11e71b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define TRACEFS		"/sys/kernel/tracing"
+#define DEBUGFS_TRACING	"/sys/kernel/debug/tracing"
+#define EVENT_SUBPATH	"events/bpf_testmod/bpf_testmod_test_read/btf_ids"
+
+struct btf_ids_info {
+	__u32 obj_id;
+	__u32 raw_id;
+	__u32 tp_id;
+};
+
+static const char *btf_ids_path(char *buf, size_t sz)
+{
+	if (access(TRACEFS "/trace", F_OK) == 0)
+		snprintf(buf, sz, "%s/%s", TRACEFS, EVENT_SUBPATH);
+	else
+		snprintf(buf, sz, "%s/%s", DEBUGFS_TRACING, EVENT_SUBPATH);
+	return buf;
+}
+
+static int read_btf_ids(struct btf_ids_info *info)
+{
+	char path[256], buf[256];
+	int fd, n;
+
+	fd = open(btf_ids_path(path, sizeof(path)), O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return -EIO;
+	buf[n] = '\0';
+
+	if (sscanf(buf,
+		   "btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n",
+		   &info->obj_id, &info->raw_id, &info->tp_id) != 3)
+		return -EINVAL;
+	return 0;
+}
+
+static const char *param_name(struct btf *btf, const struct btf_param *p)
+{
+	return btf__name_by_offset(btf, p->name_off);
+}
+
+static const char *member_name(struct btf *btf, const struct btf_member *m)
+{
+	return btf__name_by_offset(btf, m->name_off);
+}
+
+void test_tp_btf_ids(void)
+{
+	const struct btf_type *proto_t, *rec_t;
+	const struct btf_param *params;
+	const struct btf_member *members;
+	struct btf_ids_info info;
+	struct btf *vmlinux_btf, *btf;
+	const char *name;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	err = read_btf_ids(&info);
+	if (!ASSERT_OK(err, "read btf_ids"))
+		return;
+
+	ASSERT_GT(info.obj_id, 0, "obj_id non-zero");
+	ASSERT_GT(info.raw_id, 0, "raw_id non-zero");
+	ASSERT_GT(info.tp_id, 0, "tp_id non-zero");
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load vmlinux BTF"))
+		return;
+
+	/* Module BTF is split BTF; load with vmlinux as base. */
+	btf = btf__load_from_kernel_by_id_split(info.obj_id, vmlinux_btf);
+	if (!ASSERT_OK_PTR(btf, "load module BTF")) {
+		btf__free(vmlinux_btf);
+		return;
+	}
+
+	/*
+	 * raw_btf_id should be the FUNC_PROTO of __bpf_trace_<call>:
+	 *   void *__data, struct task_struct *task,
+	 *   struct bpf_testmod_test_read_ctx *ctx
+	 */
+	proto_t = btf__type_by_id(btf, info.raw_id);
+	if (!ASSERT_OK_PTR(proto_t, "raw type_by_id"))
+		goto out;
+	if (!ASSERT_TRUE(btf_is_func_proto(proto_t), "raw is FUNC_PROTO"))
+		goto out;
+	if (!ASSERT_EQ(btf_vlen(proto_t), 3, "func_proto arg count"))
+		goto out;
+
+	params = btf_params(proto_t);
+	ASSERT_STREQ(param_name(btf, &params[0]), "__data", "arg0 name");
+	ASSERT_STREQ(param_name(btf, &params[1]), "task", "arg1 name");
+	ASSERT_STREQ(param_name(btf, &params[2]), "ctx", "arg2 name");
+
+	/*
+	 * tp_btf_id should be STRUCT trace_event_raw_<call> with the
+	 * fields declared by TP_STRUCT__entry plus the common header.
+	 */
+	rec_t = btf__type_by_id(btf, info.tp_id);
+	if (!ASSERT_OK_PTR(rec_t, "tp type_by_id"))
+		goto out;
+	if (!ASSERT_TRUE(btf_is_struct(rec_t), "tp is STRUCT"))
+		goto out;
+	name = btf__name_by_offset(btf, rec_t->name_off);
+	ASSERT_STREQ(name, "trace_event_raw_bpf_testmod_test_read",
+		     "tp struct name");
+	if (!ASSERT_GE(btf_vlen(rec_t), 5, "tp struct field count"))
+		goto out;
+
+	members = btf_members(rec_t);
+	ASSERT_STREQ(member_name(btf, &members[0]), "ent", "field0 name");
+	ASSERT_STREQ(member_name(btf, &members[1]), "pid", "field1 name");
+	ASSERT_STREQ(member_name(btf, &members[2]), "comm", "field2 name");
+	ASSERT_STREQ(member_name(btf, &members[3]), "off", "field3 name");
+	ASSERT_STREQ(member_name(btf, &members[4]), "len", "field4 name");
+out:
+	btf__free(btf);
+	btf__free(vmlinux_btf);
+}

-- 
2.53.0-Meta

