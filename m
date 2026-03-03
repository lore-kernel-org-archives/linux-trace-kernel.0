Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59533E35C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539139; cv=none; b=R4ekkS70xF2qQhaQBwE/Q0lLJoeXaZaQDne9pqQMDGqPpAbQm/mGJJ+eIcAZUflA5WToFEQmugGln1ZZ6gphEMohIuR2HftlfPfB75c+RzB+8W0QvjPKj5aKadaql4U3XqHzn4xYQMXpwuGuqeod7e8smOTnk8ZGc2tU8gEwfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539139; c=relaxed/simple;
	bh=xfJlsDitPFNINo6PdvW9xIIO5tUhmZ1J+GBfu8WBap4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6R3h/w6SzoRHBcwQ8IICrH3vbyuZiJfcJzuFJQXg+a0jwUy1dr0JZ+lKzD4ShFIFuAMkeaX88w0jn9MpQjqBf5sAf/JeolmEcbUx9l95HPtpUXGuUZgvxtJ1strBQzoBfmmnI2nSbsBz4lSBTo7Px8NEdJCVZCsvqzrBTVbxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KaxeklF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaxeklF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772539138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4CtqcFVzp3mF5EfycFswotSYwJN7isvCXXnUa2seYY=;
	b=KaxeklF7xtwESz0AgU7Ps7WBkup1wixV6rPqtYGoP1WIlXG15vdomH9c+v6BRmgCtUlGop
	Apy77eTMV+Nz2h7SOX9dXGcW+YpDobem51Aw3WJfDZUmxJ2ux4dPK6X3MHpWVXpDnXtcQm
	lGao1dm04KhMP7SifF4mQQMtA2vvzCg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-tcySFEwUOHmvKbApJ1mUQw-1; Tue, 03 Mar 2026 06:58:55 -0500
X-MC-Unique: tcySFEwUOHmvKbApJ1mUQw-1
X-Mimecast-MFC-AGG-ID: tcySFEwUOHmvKbApJ1mUQw_1772539134
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b937607a902so536430366b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 03:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772539134; x=1773143934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4CtqcFVzp3mF5EfycFswotSYwJN7isvCXXnUa2seYY=;
        b=kpY/X5uqp5SJ3prY3vV4Bh5d+jb5HSVcTJmFlaAgJwnymaoOI/XZRBkgoo2nZ5EvXQ
         XrFQ/8r0zhxhZWzXooTZMFhrgmDDnRZnD6BY1i0xHJen8vo15hOC1KBcQb0DkEvTssD2
         sTw8x/eeNCMuhJdrbUN8dxxOpxHoT1giKfSYubdCGgz4BpkVQzpOugGo6Fd9MKmH1Sxi
         tRUeDJ2ERxnhvky362CxCFFF8/CfQhJ96PbHNI30IPQl7DYtG62VSefVfYSdb8q4raRW
         2r1Fh25AvVnQ65OnueHEjGiwnjxbAWTD44dxvtX6WwMhLGz9JBJ/a4D+QzgvMwq8wQv/
         lNDw==
X-Forwarded-Encrypted: i=1; AJvYcCWvwwrWSBmbto4fPqvI4HaYsbKB+/H8ChhNQWaJy47jyDMt5QskQF7HRUX+HAKgYkJ2cfmIDbqoIRjuXzqbML7HHZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4jshVo8GS7psGFxtdj5huYKDoUXjunOsx4NKpkc1S75BHi1S
	deVMMwxRa2AlsZTT0l3QJ1L/go95mtbRh2S5M7UZGpizW+BY8324AKtfizUsopAGmmDXh0+OcZc
	ztfaFjUPrangRouRCQzAqT9IKtyZTGUeVjGL8HmjTRG0AmTv51Fn+8M9POGN65h2QNnavWN02ei
	uRRB5LImk8D5Ec0MYklBuAK4nU5B4mzpmFMuZVhy8ZoCJH5zM2
X-Gm-Gg: ATEYQzw+frCMvCnRi4ecPI00KoE7UwtKj4QUCiTsbZA8GflfCng9CJcfuy3eq5Da5YT
	w5Yg5tZBkWRuMKiipfXhvxPnFvxco3o2lGl1uD2jchft4avedkg/YAhOVUNjQgGYF5EJKvofHlm
	mKtmVF4CpAxRsvU3DzYz5Z4boP2h9TBssmnkyBpkhbyKgL9oQuelSbwBre61EkuoPmo89h7fkaO
	uG3TQ==
X-Received: by 2002:a17:907:9710:b0:b8f:8cf4:adf9 with SMTP id a640c23a62f3a-b937636b784mr942090666b.6.1772539133629;
        Tue, 03 Mar 2026 03:58:53 -0800 (PST)
X-Received: by 2002:a17:907:9710:b0:b8f:8cf4:adf9 with SMTP id
 a640c23a62f3a-b937636b784mr942088666b.6.1772539133148; Tue, 03 Mar 2026
 03:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-4-wander@redhat.com>
In-Reply-To: <20260115163650.118910-4-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 12:58:42 +0100
X-Gm-Features: AaiRm5063jBEqkXltmA3PT-me9_BDiQPgb3Y2Uz23cyuYoxnZQPISFkwvAHn7aA
Message-ID: <CAP4=nvTcKc+=usb0N_Te+dR+1+Zt0d6edaQD+xbyBXq_TC4LQw@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] rtla: Simplify argument parsing
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0JlBYpd-5K7JahE7C1fWAHaGTpv5_6m33GfRLJH8A9E_1772539134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:25 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The actions_parse() function uses open-coded logic to extract arguments
> from a string. This includes manual length checks and strncmp() calls,
> which can be verbose and error-prone.
>
> To simplify and improve the robustness of argument parsing, introduce a
> new extract_arg() helper macro. This macro extracts the value from a
> "key=3Dvalue" pair, making the code more concise and readable.
>
> Also, introduce STRING_LENGTH() and strncmp_static() macros to
> perform compile-time calculations of string lengths and safer string
> comparisons.
>
> Refactor actions_parse() to use these new helpers, resulting in
> cleaner and more maintainable code.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/actions.c | 57 +++++++++++++++++++++++---------
>  tools/tracing/rtla/src/utils.h   | 14 ++++++--
>  2 files changed, 54 insertions(+), 17 deletions(-)
>

Suggestion in case you will be sending a v4 of the patchset: the
commit description could be more descriptive, something like,
"rtla/actions: Simplify argument parsing", or "rtla: Simply action
argument parsing", to make it clear this affects *action* arguments,
not command-line argument parsing in general.

> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index e29c2eb5d569d..8323c999260c2 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -14,8 +14,18 @@
>  #define MAX_NICE               20
>  #define MIN_NICE               -19
>
> -#define container_of(ptr, type, member)({                      \
> -       const typeof(((type *)0)->member) *__mptr =3D (ptr);      \

As Crystal pointed out already [1], this part removes container_of,
only to restore it (see below).

[1] https://lore.kernel.org/linux-trace-kernel/301c25518ff81dc967187497a057=
7f8ee2fb2e29.camel@redhat.com/

> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
> +#endif
> +
> +/* Calculate string length at compile time (excluding null terminator) *=
/
> +#define STRING_LENGTH(s) (ARRAY_SIZE(s) - sizeof(*(s)))
> +
> +/* Compare string with static string, length determined at compile time =
*/
> +#define strncmp_static(s1, s2) strncmp(s1, s2, ARRAY_SIZE(s2))
> +
> +#define container_of(ptr, type, member)({                              \
> +       const typeof(((type *)0)->member) * __mptr =3D (ptr);            =
 \
>         (type *)((char *)__mptr - offsetof(type, member)) ; })
>

...here, container_of is restored, only with one more tab which is
unnecessary - that is why Git includes it into the diff. If you remove
one tab and update the commit, the change should be dropped.

Otherwise, looks good!

Tomas

