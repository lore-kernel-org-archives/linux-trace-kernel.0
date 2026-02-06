Received: from sg-1-106.ptr.blmpb.com (sg-1-106.ptr.blmpb.com [118.26.132.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AF3612FE
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770377185; cv=none; b=ktazcEKcySVUHD+ZYRpskQb+71Jtdp++jL/lWYGU8FTz9lgeXc0kGguiu1Yk1879NJ/sBMlwx7jQT3OpR8IeEPvgbm6rZmyeECsleQkC1jFRhGcVAmbHmCnwok2Gzop1YvAM6pB4MdEWD/7nzoGEKiWdQMewZ2xnn6z/HQIbgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770377185; c=relaxed/simple;
	bh=4PKw6eMDQH/9D5AFdHiZ6Enr2ec/oDFvJsmjmWeg/Cw=;
	h=Content-Type:Date:To:Cc:Subject:From:Mime-Version:Message-Id; b=GjDQM9rLh7E6BQaobtjEg0pIyvpcs87RmQ3aPckjy1AGeme3/vl7unX/InIAHgFwqRXeLR2pTv0IPHbleN7NYJQR5VUsFNACKBpGibY/VPm1o1z6PNemtBg7TVeF9b6PgaU20thtDb9RpECOz4jzjVqhsdIMHTqlvNFPgJqoXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qGr9ZUJK; arc=none smtp.client-ip=118.26.132.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qGr9ZUJK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1770377172; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4PKw6eMDQH/9D5AFdHiZ6Enr2ec/oDFvJsmjmWeg/Cw=;
 b=qGr9ZUJKXKarww/Q4K7V/UqmhiSGqQ7B3wLvQPMeitQnTBIbRo1atMH7o4HTRlvsD5921b
 +EX0VjvJopCZpYL9K9axpaFZHtsr9MyI7JvQ+MW49sRDfJ9x37YwCjVtv2HFB7sFVAhtU5
 75lTwlwte4USvfTQmEzxi/uDsxVISm/FED4zngztf6VBQXhg0jF27u+W6TJ4gBxxptI2WB
 qnOEPNYFohU3l5RfAmekb4ciPOoW1E1ocMTVeQZScKfvPrTLiR6q2m+4dECElPYxWyu0Bo
 r4TX/m1Wr4Qp1c/zkI0KBI75HwFfqOuSaYjyv+zwxviejbrCK9XvpFQ43Ry7SQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Feb 2026 19:26:09 +0800
To: "zhouwenhao" <zhouwenhao7600@gmail.com>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, 
	"Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] objpool: fix the overestimation of object pooling metadata size
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16985cfd2+c03398+vger.kernel.org+wuqiang.matt@bytedance.com>
Message-Id: <f9227920-a1a7-4f12-92d3-225e8753b32a@bytedance.com>

On 2026/2/2 21:28, zhouwenhao wrote:
> objpool uses struct objpool_head to store metadata information, and its
> cpu_slots member points to an array of pointers that store the addresses =
of
> the percpu ring arrays. However, the memory size allocated during the
> initialization of cpu_slots is nr_cpu_ids * sizeof(struct objpool_slot). =
On
> a 64-bit machine, the size of struct objpool_slot is 16 bytes, which is
> twice the size of the actual pointer required, and the extra memory is
> never be used, resulting in a waste of memory. Therefore, the memory size
> required for cpu_slots needs to be corrected.
>=C2=A0
> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC"=
)
>=C2=A0
> Signed-off-by: zhouwenhao <zhouwenhao7600@gmail.com>
> ---
> =C2=A0 lib/objpool.c | 2 +-
> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>=C2=A0
> diff --git a/lib/objpool.c b/lib/objpool.c
> index b998b720c732..d98fadf1de16 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -142,7 +142,7 @@ int objpool_init(struct objpool_head *pool, int nr_ob=
js, int object_size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pool->gfp =3D gfp & ~__GFP_ZERO;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pool->context =3D context;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pool->release =3D release;
> - =C2=A0 =C2=A0 =C2=A0=C2=A0 slot_size =3D nr_cpu_ids * sizeof(struct obj=
pool_slot);
> + =C2=A0 =C2=A0 =C2=A0=C2=A0 slot_size =3D nr_cpu_ids * sizeof(struct obj=
pool_slot *);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pool->cpu_slots =3D kzalloc(slot_size,=
 pool->gfp);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pool->cpu_slots)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EN=
OMEM;

Good catch. It should be "struct objpool_slot *".

Masami, could you please review this fix ? Thank you.

Regards,
Matt Wu
