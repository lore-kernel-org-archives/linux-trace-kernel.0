Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337064FB9B0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565551; cv=none; b=uRCknh0SSVy2QlQXNnvqk1/mn4rqZiXgE7iPuyOzoHQokDfoKMFRTftEK8R17hka07KCLcj7lxUGrRA4BNrxubPtir/efpdEnhBDTgVCWMwKvdFdT7q8AntddrwP3EO8+2Z40afFvgJ5Vieo0mrGylWLPhAT8JwuvW+9aVPD7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565551; c=relaxed/simple;
	bh=KsuApQ6jGsBL9H1Lg6ZPp17XC38wi5V1uyun2b7groU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFxNwMwg9Wg3v+eVD0FVoxOBvKb5n8fSTS0qYUnZxC6cC2avZxQTlN1QBL5BN9cGQ11XdtotCPC4dzQHav48mNYb0e1yoinCjUcbf6S1NSc7xg3oPSygFVuaYFg4HPFcc17PsdcgxbIHYWWUbU+I8j5wjaVgu79Pk3qk8lSHyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMT+C6Dt; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMT+C6Dt"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso52683a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565546; x=1790170346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iCcn2LkYFEOrgsqYd3Ql/075Xn3VWWErqZWMbblb648=;
        b=HMT+C6DtikFWg1GGY1QsMdA+B10uV8lOn+gpsA6i8QT34RMF2oo7xu17OHGsLDk/tL
         O2VltJQydWXfBf08nxVgPd8lo+0flMQkmcbxUl0GMXYlbC+3r+qwErQ5We5QRCOjRy2o
         kp/qJej+WXTq8wLunaZjpGQfZqF237DSiFyZuuzEdo3JpjU3gAWfWC7P7hCuysFwXPQX
         mbJLIhp3kEMh1BQhZIKn2UXt1kFfVw+dgK4Oggd3bk4JsakoahxC/JdmQgYayitQjEst
         TnLYMITgUUfeM2gZ/gPn0oe2Umw8kQjCR9LCm51zXanhQTHh21hpPxq9uX9P7w9WwiuY
         MpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565546; x=1790170346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iCcn2LkYFEOrgsqYd3Ql/075Xn3VWWErqZWMbblb648=;
        b=yXpJnnjgxqnVhMyI6MUbg03CG6lsUWBB6lZ7WYcAwyUumTRxue15KvCCe0+Gt+2buW
         d1EK7fQMJJAPHo20447TUhQIF4GRAWzdxdxCrJ9EtArLwshdHdjnjldyaYl+7PJsOA0j
         ezMsIegO/RmpiPqFAS++GaxVb+fCsQ88XLsQe5+hTtHU6GUS72DjPpBdwiq89XMKcD0L
         owUXak8vkRgCPQeHFd35FByTgFV9TtpOvMm6fiy2nTk5edKMHhzsvMRkBPEdH6SO/vKY
         kWcVutHD7RdCaHrHg67/6FSnBYEEAUludfBZszuqiTl9551wie5LaerJ+pIO5ArISZ5q
         KKLg==
X-Forwarded-Encrypted: i=1; AKwUvBxndrgVymrVvF2fYaVdxhstUrdMYLDCqG2TNjiCr0IrZOKYXutjCR/pev7YAP9lIF+GEXpn535fysIoWywF3x3GLU0=@vger.kernel.org
X-Gm-Message-State: AFuF++mNQn58VeQ+qvLkYMvv61S3JXR1E4hX5/PGqrnBx2I8tDOh01Ux
	Gl8DaufzpcgosX0yIaMp1W2LvTNht0GitDCxrsRgF2SVwB133eBfsx6E
X-Gm-Gg: AYBFou2k2Hm/ph+dAK4SGGe5S+VY5BPpcr+lp60O25LxWG64fPz6zNoWLghiYfV7Xqk
	+snCbvWev4boPoyyk2PHEXPXhdhMv7c1AXG3tLFnENV+S/ie7yo/1fcCg5oIKriCXYwt+OwhxDr
	PwfCm41mgKx8yRLpkBV8R/SxP7uny8z/FSAMZm8Xx0WjV/WoCmoUwTleOb9lqQjV6qKknDS//XV
	FF6By4SokLKS2OaJDRWXLbSjz/4NVYUxyS4Y1XEkcnwVIgqCXQ5IDfW8qOK8soCpvqMdqkvgiQj
	SBiRuxHMeZH1ShpnTjIMCeOM5aMrs2yDM5BGTYEgCbNaOk4QnRkZS8Gheo0joSMpBcTl751kzvr
	PvqxSH8ItGzCcqnHJ3kS+XSToOu+o6DvBsPjjJG9VFifDBKEXjKzltCmnq3xzGng591TYNENGI7
	syOn1af4zb0Mp3n7j4kayA75QlSHBHNRTRszVzuPY0heZX5h9nw9hX3YXaq5dbcSNp2/jbVyikY
	oavVro+oEtYvJ8=
X-Received: by 2002:a05:6a20:430a:b0:3da:6bdd:2308 with SMTP id adf61e73a8af0-3dd5f5d673emr6093359637.18.1789565546497;
        Wed, 16 Sep 2026 06:32:26 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm1651702a12.20.2026.09.16.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:25 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v6 1/4] tracing: Avoid BTF lookup in atomic context
Date: Wed, 16 Sep 2026 21:32:15 +0800
Message-Id: <20260916133218.1282590-2-dolinux.peng@gmail.com>
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

The function graph trace formatter can be called from ftrace_dump_one()
with interrupts disabled. When ftrace_dump_on_oops is enabled, the trace
panic notifier can reach ftrace_dump() from the panic path, including the
nmi_panic() path used by the hard lockup detector.

btf_find_func_proto() calls bpf_find_btf_id(), which may initialize vmlinux
BTF under a mutex. Skip the BTF lookup when running in an atomic context
or with interrupts disabled, and fall back to the existing return value
formatting.

Fixes: ebeed8d4a555 ("tracing/probes: Move finding func-proto API and getting func-param API to trace_btf")
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25..ae562192b619 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -15,6 +15,9 @@ const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **b
 	const struct btf_type *t;
 	s32 id;
 
+	if (unlikely(in_atomic() || irqs_disabled()))
+		return NULL;
+
 	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
 	if (id < 0)
 		return NULL;
-- 
2.34.1

