Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295F1465B4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031595; cv=none; b=UMdXU1kE5zhbZrspKwdCuRZE6Op714aw3Ax84NibhNIcasccN+G8PQawIJ6D2AB9VtoI71ZJI53HfZNV9dCb3LkinhWCtFU8EgTPb7wRmg46zWk5mqV8y0OzPq5pcLpah3A1yZA2Lh77ACYZoarFvWMmGoySOt+8YwbAXZlSyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031595; c=relaxed/simple;
	bh=C/A3splpSNKFiITZFLnlPIVEGljiuOjmXhoqkM2uSOU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgRV2R653pGCTPb4vn9G0J4QgmZiueYY1IDgqAt/eWFpSiqm6KSQ9zhXh4nGIvPgi7cT8JdxGtOp7yApRN/aV/xJKeipefSUaT/AQRqZ2RDs6mcrs7aWfA3Kk12ZWOyXcSLcFS7xS/7j2zBQaXS/79pigtnXNGJOmKnVssfk+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/Bw7AJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/Bw7AJq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764031592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEsFkA30SGoL9PUtwNLUn5lZrjWEW2Q2Saq3fE10Lbg=;
	b=O/Bw7AJq2XToBZ++pspqFqFGSqUKVhN1048i7dmkqRnVvR9i6EaD6l7jy+5L0vsmwKYIqn
	KUrJnaPKx3Vnaaj2Svec000t9jcMrbDi6sJvwZPe2AcVRp/Yo4LMM53SK3DQlXqr2dsb6z
	MKU0j+cBMCSJzqs+kO/zwTbxLsfv0Ns=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-xR2eLizTNp6f1mts_p4gTQ-1; Mon, 24 Nov 2025 19:46:31 -0500
X-MC-Unique: xR2eLizTNp6f1mts_p4gTQ-1
X-Mimecast-MFC-AGG-ID: xR2eLizTNp6f1mts_p4gTQ_1764031591
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8823f4666abso128563306d6.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 16:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764031591; x=1764636391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncItnG6r8wEZMryKPwalIeSOSpPfyXeplwJX6HDv+pg=;
        b=FL0W4O9sInlUfcY2qGFJtpSDfehBjUhKfxLOrtoxoWlhv5GQhdYGnd7mbSathIt3kZ
         7WPh7ldt6QvxVngviS48ldXgkl3HydNs3XzlzP21p5OV47WUjZ5/jIPiv0RCkFemEZ4E
         geOLnqaIdOGBeaEPthFjMnxa3Wf2TXP/0LbjM5UJHq9SnrbVeqO2W9CO2J9IK/a84Lks
         OG23OjOrd2MHHfLfom1jn6r7/arfoPKJLOPvFd/3t+nOBbTC8rYqkg/iHmlEtUD3jnDO
         V7VMOrnoj5ohB7BexrRvv9SG5237uOajgvHUvwvk784lccECIqm7lTMBn38B6d3uyI7x
         J97A==
X-Forwarded-Encrypted: i=1; AJvYcCWyFfRto+0eIaPR5dpKxf1MzMDIrEoC4/zZYct/T3+SU9yreAl3odwn/qR1/Ztq/Svo+OS1uOF3jW3vNl35nPeARks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3CZvFDA0IcTR278nNXNW9BddgGyW+Yhes9YaVGIsc+zUOtIg
	ZFhYSV/b/SlfK5UJGetLynerR+2Z0dPKRF2gl5zXPNbOU3/TCvzb+i0b83FjjD2+l3pn3sKTlev
	vg20jOFPLAvMUJE76s0sZSAQlAy8Yx4gSXwNJQ63BwhZWIddbGEzsSyrtpQ3pzk5dBChzqvlXRA
	==
X-Gm-Gg: ASbGncsM+cx+CAedYPqsdqjT/ob6fB0cm73EFqs1ObpYJZHnYae2fz+r1bKcsIBAPiR
	vR9+cPzi36l23bAi22XF5u36b4WBzo16LqGtzeGFhtNToJExMFbMrytgjKjkw8BRcm+j6NS7NUT
	86TqH6jXMPro+h2E7m9a9gpx02YdIYdw1Ic4SY1MCE5SicYujan36M2710Zz3vT6CYw+B3Lh08n
	L0AJTn+hwwVl3lxwjexSARfY2aC+qfPX2F31QTxKQ3MW+TfOEialHPOG6qdG3/A59bJfmGh9uhg
	fmWCi83nSTa5iut2NyQzXe2MS/RbLdBFuwzKBEuhOXFAKEaWQS1KsHS6DuMuj9Sn9Sre9jGuPfm
	rWzYOopio7oXXEpNnnQO0g323HuO/xduS0apNMAjElQ==
X-Received: by 2002:ad4:5bc3:0:b0:882:3ca2:f11f with SMTP id 6a1803df08f44-8847c4ca39cmr201790096d6.25.1764031590966;
        Mon, 24 Nov 2025 16:46:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoEJaswoVSDH9fyyqjPDyF/mbttDXLpmbINV8TC0fuiCOS4UY50MM0uWdGNruKowqDwIYEeA==
X-Received: by 2002:ad4:5bc3:0:b0:882:3ca2:f11f with SMTP id 6a1803df08f44-8847c4ca39cmr201789886d6.25.1764031590551;
        Mon, 24 Nov 2025 16:46:30 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e599978sm112470636d6.52.2025.11.24.16.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:46:30 -0800 (PST)
Message-ID: <9770045bcf400920152f0698c07090a641cc4aa1.camel@redhat.com>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, Costa
 Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "open list:Real-time Linux Analysis (RTLA) tools"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Mon, 24 Nov 2025 18:46:29 -0600
In-Reply-To: <20251117184409.42831-5-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-5-wander@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1SDxbRcckD7s1JIiDDXOlRHXdSGQ5MTSFOlj5--Wwqk_1764031591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:

>=20
> diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/ac=
tions.c
> index efa17290926da..e23d4f1c5a592 100644
> --- a/tools/tracing/rtla/src/actions.c
> +++ b/tools/tracing/rtla/src/actions.c
> @@ -199,12 +199,14 @@ actions_parse(struct actions *self, const char *tri=
gger, const char *tracefn)
>  =09=09/* Takes two arguments, num (signal) and pid */
>  =09=09while (token !=3D NULL) {
>  =09=09=09if (strlen(token) > 4 && strncmp(token, "num=3D", 4) =3D=3D 0) =
{
> -=09=09=09=09signal =3D atoi(token + 4);
> +=09=09=09=09if(!strtoi(token + 4, &signal))
> +=09=09=09=09=09return -1;

if (

>  =09=09=09} else if (strlen(token) > 4 && strncmp(token, "pid=3D", 4) =3D=
=3D 0) {
>  =09=09=09=09if (strncmp(token + 4, "parent", 7) =3D=3D 0)
>  =09=09=09=09=09pid =3D -1;
>  =09=09=09=09else
> -=09=09=09=09=09pid =3D atoi(token + 4);
> +=09=09=09=09=09if (!strtoi(token + 4, &pid))
> +=09=09=09=09=09=09return -1;

else if (

Please run the patches through checkpatch.pl

> @@ -959,3 +967,25 @@ int auto_house_keeping(cpu_set_t *monitored_cpus)
> =20
>  =09return 1;
>  }
> +
> +/*
> + * strtoi - convert string to integer with error checking
> + *
> + * Returns true on success, false if conversion fails or result is out o=
f int range.
> + */
> +bool strtoi(const char *s, int *res)

Could use __attribute__((__warn_unused_result__)) like kstrtoint().

BTW, it's pretty annoying that we need to reinvent the wheel on all this
stuff just because it's userspace.  From some of the other tools it
looks like we can at least include basic kernel headers like compiler.h;
maybe we should have a tools/-wide common util area as well?  Even
better if some of the code can be shared with the kernel itself.

Not saying that should in any way be a blocker for these patches, just
something to think about.


-Crystal

