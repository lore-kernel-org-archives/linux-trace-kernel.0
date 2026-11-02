Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620733;
	b=BtBO+fvQkzUTxlp79juvN7xK8vlqOgmIfKJ40I+hT5KAzuxFS5o4I8SYhe64fkEKfk1g
	 Rt/sgr9TpzlLAeqGMjijDsCTsRuQoNPAGNsJHQ6bm01etoEUcaj8YQX66qWprN++sZRXz
	 w3u9yBv8tVwIczFdDSn/2bJRdn4o1OMV2eMuE8Z367AOHgPBSRiJuxnbRBj4M705N5IwY
	 H0ofULfg8KY9JF3LkcXIfGIlVYf/qr4tPAVP4q/PL5eEKKlEMVOswHc0VUVKJL37pDEO0
	 PJXHaBDSElk0JUjzXe1D/+Z9MrX4cxLVA0F8ooveYdRYTf6vGK8u2aHZGYY0nmPVQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620733;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=NuXE4tOkwqOxwupDOtttrp0r4Jp94NWgATIQW3W8F3c=;
	b=tQwrK282ZaDKzv0TqDg9uH5k9Jka8cA0+D90bkdVj1tMYIHZch/mAJz89avbLe9xc7w5
	 HrWgVVggh01CwpFIlm1/gc2G+a+782vCa7GyBArikOLQOeFX8moer8GTZaGNDT4+lPCFP
	 5TlcVUclnJwhS8pGuiD5rXEuDQeXjRdUMUHXP0mtEaPKJqh3dpR2Vh0G73ejRhrIPNbi0
	 yNDluxlrLzzHOCuHK27eOj1qBMOCZAkv9DPDrfzZAJbQSSWrAV1weJ0QH0qPyhUn2gV3s
	 oo6ejAFEBtrNBgoxJEqM18/Dv/k5nlDmFhQ8eFbH9C2Hbfc9UiPonyOwxV5OVcz79Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=ZCVbGVgB;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882060A3827;
	Mon,  2 Nov 2026 11:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D882060A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=ZCVbGVgB
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b234e;
	Mon, 2 Nov 2026 19:58:43 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071771.29269.12274333629550524596@stu.pku.edu.cn>
Subject: [PATCH 1/2] tracing/user_events: validate dynamic cpumask size
In-Reply-To: <179362071771.29269.15129360535376085397@stu.pku.edu.cn>
References: <179362071771.29269.15129360535376085397@stu.pku.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c2047a703a2kunmab045f0fe84e5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSktCVkpIGUoYTU0fGBhKHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=ZCVbGVgBMoWhuKqRiv+PwEcBJO0otvEmV/L3NilBzZEq2DIv7DGVIHQ83wr0iw3d6QcV/7uvPxmxY9ZSZyq4tpmVjBampefZVfGS3cyM591TY34E6l9jjnCOAPK84mFJCCKv96bxSKQ0oYcQDEcGqohUoGRn4mQ4yp7K/NCyzSs=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=NuXE4tOkwqOxwupDOtttrp0r4Jp94NWgATIQW3W8F3c=;
	h=date:mime-version:subject:message-id:from;

user_event_validate() checks that a dynamic field lies inside the event but
does not verify the minimum size required by its filter type.  A one-byte
dynamic cpumask can therefore reach filter_pred_cpumask(), which consumes
cpumask_size() bytes beyond the event buffer.

KASAN reports:

  BUG: KASAN: slab-use-after-free in filter_match_preds
  Read of size 8
  filter_match_preds
  trace_event_buffer_commit
  user_event_ftrace
  user_events_write_core

Mark dynamic cpumask fields and reject locations shorter than
cpumask_size().

The patched kernel rejects the short event and accepts a full-size control
event without a KASAN report.

Fixes: 2467cda1b5c9 ("user_events: Validate user payloads for size and null t=
ermination")
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 kernel/trace/trace_events_user.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_use=
r.c
index f658c3a77aa7a..85938b45b7618 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -170,6 +170,7 @@ struct user_event_file_info {
=20
 #define VALIDATOR_ENSURE_NULL (1 << 0)
 #define VALIDATOR_REL (1 << 1)
+#define VALIDATOR_CPUMASK BIT(2)
=20
 struct user_event_validator {
 	struct list_head	user_event_link;
@@ -1159,6 +1160,9 @@ add_validator:
 	if (strstr(type, "char") !=3D NULL)
 		validator_flags |=3D VALIDATOR_ENSURE_NULL;
=20
+	if (strstr(type, "cpumask_t"))
+		validator_flags |=3D VALIDATOR_CPUMASK;
+
 	validator =3D kmalloc_obj(*validator, GFP_KERNEL_ACCOUNT);
=20
 	if (!validator) {
@@ -1598,6 +1602,10 @@ static int user_event_validate(struct user_event *user=
, void *data, int len)
 		offset =3D loc & 0xffff;
 		size =3D loc >> 16;
=20
+		if (unlikely((validator->flags & VALIDATOR_CPUMASK) &&
+			     size < cpumask_size()))
+			return -EFAULT;
+
 		if (likely(validator->flags & VALIDATOR_REL))
 			pos +=3D offset + sizeof(loc);
 		else
--=20
2.39.5 (Apple Git-154)
