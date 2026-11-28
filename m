Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795844962;
	b=BbXit9sUWKeb0piScBqrlWSh/py/Zm801UYzyPw2YPFv4x0tPTYEmVjafZXarvkldtaK
	 /fCZPL+7bKPKfkaT9ZBChl3a/04tc8yIiAM6vp8p7bZQJR7VzdiaREwH2jwnFfDncmjP/
	 PrwqlcITfWkEZ3iAqwz2qmc46ba++eDfExgRE7/Qldw9S8GXgVQkJ8iTbfO7D7KFWwx21
	 MGMLYuiGYBQvggi7RE3/4y5TLcwVVevPC9ZXS7RiLXyRDOFMMasML/69ZBDmU07UTwve2
	 Cp6TF1yACuCfQP8WY0LdKh+adsJ5z9a9fuj0GQzdw37f1eCU5J4tuPVx7h3d+z9lR6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795844962;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YMrvu6NJY616Ft2g66ba3nF0V4dJahF3IgcTUj/xAW0=;
	b=nw1JAH+g59I1xPW98YrmgndpMRbd+Ukl3RbhNS+emS15+UUS9aGWLhpHNcnR5i5EiLT/
	 zNHgRvDmvxKDmKsVS6GCvVFIH1A+HyZXpV3MWLHj8YbF2nC2LwnVoxf/fqSO1dG1OERH4
	 Xx0CTtSNEX4VQH1FkE9NgKqN88Cu0dCdl3Y1GBXldf/8/kx/YaeL8PqNkbb+gkjjByQmc
	 In/nA8LcoZpSZX40zyEKNyzBN7EWsTdAL3hoUY5BBKpU1PAwpHGloL/CktTFXdv/LAqL/
	 cHCrFU9yu/hTbNAZJE7ygO0KGuFv4o3QYh2uTKJebP3DhPkxpo+NupzYa/tMMtDlNUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Dc4WZ7Xu;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCF606A31F;
	Sat, 28 Nov 2026 05:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBCF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Dc4WZ7Xu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=YMrvu6NJY616Ft2g66ba3nF0V4dJahF3IgcTUj/xAW0=;
	b=Dc4WZ7XuoOda/1gzWNvODtUp21OG8KFLFlQYpwjPTS8XNTFUQroN1AVIDdD9Oi
	nOxS6JxueIbbtj82QrZRvp+MFmrp61JMtOpbiZ5R5o7NIGr+f04qzHPrXpuNsLHJ
	aZPpL7vJQqtNN7n3Xu+a8AnP5NidZLXnYRSr/2VDttVwA=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] rtla: handle SIGTERM during a run
Date: Sat, 28 Nov 2026 13:30:20 +0800
Message-ID: <1795844918.22303.278378463762271@163.com>
In-Reply-To: <CAP4=nvSFE95SAvysnn2ay880DgFUrqQgUY1A3pTcSTXagdiDNg@mail.gmail.com>
References: <cover.1795262546.git.chaosheng.qu.linux@gmail.com> <328ecfadb98649f317985124b6b49bae2d356bcf.1795262546.git.chaosheng.qu.linux@gmail.com> <CAP4=nvSFE95SAvysnn2ay880DgFUrqQgUY1A3pTcSTXagdiDNg@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXb2ZGawprn5woKg--.33355S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1DJr45Xw1UXFW8Zry3XFb_yoWfurX_Kr
	WDCrn7G3WxWF4fXwn2yrn0qr45KrWqgrykJr18XrZIqr98GFs3XryvkF45Wr1xGa43XFnI
	kr4Iya4fur1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREwvK5UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAdJvmsKa0cibQAA3y

That matches what the tree does now.  osnoise_enable() starts the trace
instances first and calls osn_set_stop() afterwards (osnoise.c; timerlat.c
does the same before its own osn_set_stop()), so a stop_tracing_us left
behind by an earlier run is already in effect when tracing starts.  The new
value is written too late to protect the run, which is the reset-on-start
regression you described.

So I agree on both counts: the SIGTERM part is not the fix for that, and the
Fixes: tag goes.  I would rather not send a v5 for a tag alone -- drop it
when you apply the patch, or say the word and I will send v5 with the tag
removed and the changelog pointing at c219d4ee1d6.

2/2 is independent of that and can land on its own.  If you want, I can add
a case to it later that presets stop_tracing_us before the run and checks
that rtla overrides it -- but that test only makes sense once your reset fix
is in, so it would come after it.

Thanks,
Chaosheng

