Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85023777
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724980; cv=none; b=SFulJjofrsk8IUy2ikGpx2dlR4GQnzJabhpHyNmoOZ9pcUmGW2uT7tf8JPhkHQLYBqAS/zcUh94wcSW2hKCYq0r12HorKiSHGHnYbXFfw1SCm2jnT4ighDHViNwKwP+dsPu0nN1nOwIOHQj01Xb/jbAStEOPvXMYJoQ5P1B1soM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724980; c=relaxed/simple;
	bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP2WNc3l6C1XmBh8ZLrRqkI03+rnxbL0HL7zFmM0pVeU6/e/HvZkHdhpFiGckJzZZT0fHxUltmvtGqB9yWCANK1BmAP+A2x7Yh/A3gpsc6yx1gujEKol9oCAzOm3nnYTZAY60DBX6ftw8LrEENv/uA9Txg9d/8Y3r7CDuTyOlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysXS1H4f; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysXS1H4f"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f97a4c4588so3340480a34.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718724977; x=1719329777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
        b=ysXS1H4fS2mPV03Y4L/m84FKCjlkHSxi4xOu32dnqb6LzOwsyaraZoWoQH+LcpDk1H
         cFgLindy9f2RhCTqS2qdoZsnPhxjDYvAYZAuddd4mGhwuKseFVr+T63p/7jRFd9y+8Cu
         iq0nWFCXflnt8DFMsx1/RMCPABIQxCQpdHxEGONq+sFpQwMV16Ue7TY3DTYPNXp/mhaL
         MO9tdYbrl+a/D/gLdejAg8ugwKJEf4tbZHMNevcmsVyEtI1oi6TnGsm6KCITtEcIjsmo
         X9j0hF2G1+SGmpdKf/cBeoxvm0rOSp5qNU5/nl/oIjxpF4+GluSqPb5OiFNDRVFGRs8d
         BLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724977; x=1719329777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
        b=nygIAl0DlZZIek8pbLpxfbcGmLeTLsauxU5RYA27dqL3lBDT9t5TPv4HjY8V07cY5m
         +MQLyPfqpMoSN4uDC2eJFlzsjF4OnYnO74bJWdH4DTTDOJ5fb30TqINc8mCd8m8TfyKx
         zv65q6UToNR+8xiDEoNc61hdi04TXCJJSd2LFY0kK1EWZLBGiqWzXX0r8pVeQtBZU+oA
         p2B8AqvgJopbbTO1nnIF8TrtJuQlo7eOo+vPxdhr2y04pVjk1cmA+XknPVbQO7MHCVZj
         Rdp7ZrIC3RsP7ndo7s5LN+bJVC8jU/tz5+yWi+NWGWcaaEbe43mhePZbLmecB3UbGPhU
         LSig==
X-Forwarded-Encrypted: i=1; AJvYcCWki2fcSUjPzf6Ra3BVE3J4s7aKuvnrZVOaJa6vuUKsIq+vdBDauyRJViNQLw7ka4+TCSeETjkTB12Ah7AX9uIXyeUcpPBEcqHxU76enbBxseU/
X-Gm-Message-State: AOJu0YxIWzTDGQFeJnbHW1R9mc+Od4ejZmM0bBGXko+y/nzI0kWrrPAS
	jqxT0uQOXtIb6E69khpl1XNYKoTjzOpri5utbNt+NrU2/+GVX7M/9a6YvX97jVP6jLLnl6OJCMk
	u7KBjYNBBEFfF5iFrbh3wfJUOd/jVCJay6YpA
X-Google-Smtp-Source: AGHT+IEspShaRu1ToIazyKYK7a+yojtYmsB71BOjBBtI4HtP9AWTraCEUo7NTIwtb9GkxSM1Qq0A95f/tFWqAqFyrLk=
X-Received: by 2002:a9d:6510:0:b0:6fd:6240:9dba with SMTP id
 46e09a7af769-70074ebf134mr77156a34.16.1718724976930; Tue, 18 Jun 2024
 08:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-10-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-10-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 17:35:36 +0200
Message-ID: <CAG_fn=VT5u6fn6eaqzdB4bDZ+aw0kKBta7_Ff2Thn813RG6EVQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/35] kmsan: Expose kmsan_get_metadata()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Each s390 CPU has lowcore pages associated with it. Each CPU sees its
> own lowcore at virtual address 0 through a hardware mechanism called
> prefixing. Additionally, all lowcores are mapped to non-0 virtual
> addresses stored in the lowcore_ptr[] array.
>
> When lowcore is accessed through virtual address 0, one needs to
> resolve metadata for lowcore_ptr[raw_smp_processor_id()].
>
> Expose kmsan_get_metadata() to make it possible to do this from the
> arch code.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
