Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AD4437C;
	Tue, 17 Dec 2024 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398943; cv=none; b=qxrI6AiQ6mzdmWiBAYdT++x3mQZcW47dyctb3jnMphvs7jBThVnyJf202qIYeSKvRLvwbdvMaIiueNLI5pi1/et97wcxQdXIOKmP6PmvBYYEKy0iXXW8UK/WrDgcDAPQPmv99oPvchCQ2C6X4zp6fNeX6e3rpub3WHnlukjjh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398943; c=relaxed/simple;
	bh=CaQDUIxOIMEtqnBw/A6LTtX6GxUKxbJRJ6MB22zitRg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=BIY1rMZTRy0gGNIzSscruPobgRnENqHbJ34Fd6tKy/17QmRPIkOjIMzAQ2OllHE0xl/vzEzq/r7p/Z0F3X3X5Lwu7izSavL/S7Q2kYjhNDFzwxU58J4fcTNGr9SmxicEEy6DAOLYU8zuivvOjhi1vox6Dtmgufz0alwnRyRv91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg/zBSnI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg/zBSnI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21644aca3a0so56099845ad.3;
        Mon, 16 Dec 2024 17:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734398941; x=1735003741; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUWCQu9bMeepyw57zq6LKufODvVwxEvgznMOI7r4KSM=;
        b=Tg/zBSnIRw+EdWhTBwTorlpRYnDOAYpZa1nd8TSFGVH3w4tSNh2Jz6yr4sB0UjmpMW
         iKFKIPpJon38jKVr9jq7wpp+P8Ts1xr9omsoHpVzLjmrnF9TCib+oQfydTRpVORlJSpX
         vdRP3uJpTc0hSVlMZpcQGbZTq0uOV9/7Qv1AZH5S7VceGxvJeSwfTsIhIFqguZWdRfsm
         F7wWcYktBzM/ox1mQhVyS6GXDb2HA/6gWTHUTAgpmhsqg9uCJPi7KRoR0FZbS9lSRtxt
         URWnurXwSYcLpY4WhHRLIrS1gq00J2E7mCfBVYghKaTpiz9wOH5lnkDFpEYYB5MH0fbY
         pt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734398941; x=1735003741;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUWCQu9bMeepyw57zq6LKufODvVwxEvgznMOI7r4KSM=;
        b=xH2wYwUmQmSkU9Q6nbCxTr+hQST/cItTBbOUjqPU2ci40nYvhQkoYhQw5rSR9fXdFW
         3WPFzbYcwcuOaFx7ceqqLnlOzeMqIwvaRLC+eUuqT6EkKJpUU/D/INBVJnKDDXRnNtP/
         y1c4SV98lLBnBPEz6C8ouNQoADlgVlALpCL0frS9m7dBFHpwX78HDhaHXBB3wMtj5oc5
         YVt2ILWh5CQc9pOhYYmcJGiZ3aypi6yy6YKQD+xJD3x03KqqxgHOnxyhvZ2o/svlPXu0
         cDpsS9EXUsevBz78JyIifWh2oUVuqvQZ8+fdu4SFWgmM6rEKOUSqW5puhTFVH4p8m6hU
         X4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU3yNCvwObV4MpyAAjyg7kFF+u/uZlPDgpw5+52QlLwh+K61gLgHO6DjoSDqXXrFcTqqGaqzI/QF2ylo8sx/QTkOum7@vger.kernel.org, AJvYcCXsTFDfXGT+Mj12SRC5LSwDkIK0Jk/ACF7WaMhXUF+chk4pOB7MiErp5AZqAdDdYB1tnIxaWWso2cC2W7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2uKynUGe2i6eYksAYIWY+sS6EIxk13UDv7ldX/zKkMuACwxD
	tBEdD0TLut/3IYnbKeWX5MH2B7bqx8Fy+DkMan2UtVRTxz1iLNYd
X-Gm-Gg: ASbGnculE8xO7GI00agWPsESbAjlqqmbukFuQQOKyBtZj/ix7rcx+NqnNzDrCZMd15t
	W3vJwjdHNdSXVjOOQjc+yMVcgKcWJFaxG2WBI3bFHGc7ICqk6vgbf6zCh11mgldnEQYPr0HoBeB
	7/nmjULpB7myfPZTo/Znw9dKkdzXZm5P6NnulE1ZYqtFccZYZtpEaWpMqBwtVOX6cJw9p6Pxpc/
	6bDOf8HiGLpHTO1Cfxk9u88sdzsTG+LqTFon3smQnJehu5IRnn6NC+BfdRd4kaOBET8S440e2l+
	oYPiPmE=
X-Google-Smtp-Source: AGHT+IEhCzQQnpl20e7IZlZzHPsPJ7hdyBJuRn8hoR818WmMWQsSuQhE2a3oMgqv/9gxbNynv97bZQ==
X-Received: by 2002:a17:902:e801:b0:215:603e:2141 with SMTP id d9443c01a7336-218929b7999mr223132965ad.19.1734398941383;
        Mon, 16 Dec 2024 17:29:01 -0800 (PST)
Received: from smtpclient.apple ([2001:e60:a01e:ee2e:e8f2:be36:d4e1:2042])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64068sm48821325ad.232.2024.12.16.17.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 17:29:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ring-buffer: fix array bounds checking
From: Jeongjun Park <aha310510@gmail.com>
In-Reply-To: <Z2BpY5LimG7E3LpC@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Date: Tue, 17 Dec 2024 10:28:49 +0900
Message-Id: <24508411-0980-43EE-8224-C3B81E456AFF@gmail.com>
References: <Z2BpY5LimG7E3LpC@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
X-Mailer: iPhone Mail (22B91)



> Vincent Donnefort <vdonnefort@google.com> wrote:
> =EF=BB=BFOn Tue, Dec 17, 2024 at 01:49:30AM +0900, Jeongjun Park wrote:
>> If there is a case where the variable s is greater than or equal to nr_su=
bbufs
>> before entering the loop, oob read or use-after-free will occur. This pro=
blem
>> occurs because the variable s is used as an index to dereference the
>> struct page before the variable value range check. This logic prevents th=
e
>> wrong address value from being copied to the pages array through the subs=
equent
>> range check, but oob read still occurs, so the code needs to be modified.=

>=20
> Hi Jeongjun, thanks for the patch.
>=20
> Did you find a reproducer for that problem or has it just been found by co=
de
> inspection?
>=20
> As discussed here [1], s >=3D nr_subbufs should really never happen as we a=
lready
> cap nr_pages.
>=20
> [1] https://lore.kernel.org/all/78e20e98-bdfc-4d7b-a59c-988b81fcc58b@redha=
t.com/,

I didn't find the bug caused by this separately, but I found it while analyz=
ing
the code. However, since it has been confirmed that syzbot
has a reproducer that generates oob and uaf, this will definitely be
reproduced.

The reason I suggested this patch is because I think the logic of the code
is a bit inappropriate. Normally, a range check is performed before using
a specific variable as an index of an array. Of course, in this loop, the pa=
ge
structure pointer that was oob-read will not be copied to the pages array,
but I don't think it's very appropriate to read the array using a variable
value that may be out of range as an index before the range check.
Therefore, I suggest patching it like this.

>=20
>>=20
>> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functi=
ons")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>> kernel/trace/ring_buffer.c | 10 +++++-----
>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index 7e257e855dd1..83da74bf7bd6 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -6994,9 +6994,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *=
cpu_buffer,
>> {
>>    unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff =3D vma->vm_pg=
off;
>>    unsigned int subbuf_pages, subbuf_order;
>> -    struct page **pages;
>> +    struct page **pages, *page;
>>    int p =3D 0, s =3D 0;
>> -    int err;
>> +    int err, off;
>>=20
>>    /* Refuse MP_PRIVATE or writable mappings */
>>    if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
>> @@ -7055,14 +7055,14 @@ static int __rb_map_vma(struct ring_buffer_per_cp=
u *cpu_buffer,
>>    }
>>=20
>>    while (p < nr_pages) {
>> -        struct page *page =3D virt_to_page((void *)cpu_buffer->subbuf_id=
s[s]);
>> -        int off =3D 0;
>> -
>=20
> I believe we can keep the struct page and off declaration within the while=
 loop.

The reason I modified it this way is that, since this loop will always be=20=

entered if there are no other issues, these variables will be used in=20
many situations, so I think it is quite inefficient to continue to declare v=
ariables=20
in a loop where you don't know how many times it will be repeated.=20
So, I think that declaring variables in advance and then continuously initia=
lizing=20
their values =E2=80=8B=E2=80=8Bis advantageous in terms of performance and t=
here are=20
no other issues. What do you think?

Regards,

Jeongjun Park

>=20
>>        if (WARN_ON_ONCE(s >=3D nr_subbufs)) {
>>            err =3D -EINVAL;
>>            goto out;
>>        }
>>=20
>> +        page =3D virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
>> +        off =3D 0;
>> +
>>        for (; off < (1 << (subbuf_order)); off++, page++) {
>>            if (p >=3D nr_pages)
>>                break;
>> --
