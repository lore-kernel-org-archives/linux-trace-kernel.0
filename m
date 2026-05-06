Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7930EF68
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102266; cv=none; b=dAG5p3EiRGrUA5GggrEyF1dWcJolfQTWdfSD8DBZsLzl2XoAWSqFOX/pKV7BxM0FzyvA/PCPwIxJK7EoYaNxcujuG1Tu3HcbAPHTkdTg8qQbfe3vYC7PattikfBePjTo9wbsqCH3svMOCrWAc5X+LQqle8/bk8OECAxvgSubWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102266; c=relaxed/simple;
	bh=qct9180ue/H0QODWWGitx8QQGo9oBwuKWknYkPEnMTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mweqMt8DjoxzzS1rlP1kLLT5qXpGLJ6CclSFZEWx1Jr5dYnns8Sp2ruPvCGNl04xtwR6dxJCxgOJM9t9jrwluz3mzqsErhAZjmPxQeMedlMdn+X39mAdMBwTH2F4d9deKIfL3U+JgY9Ie/BKK+C1giVRfdbfZttIFKtalr+rM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu3xUGL/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu3xUGL/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so1661735e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778102263; x=1778707063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qct9180ue/H0QODWWGitx8QQGo9oBwuKWknYkPEnMTk=;
        b=Vu3xUGL/zj8PGSEu+ykyOhSSEBJ1ab+jICL8MpBMrSDWEIelgogW3PDAd5QjgRnEd5
         AxBNgS+SZoO18GscLQ9Su7VcPYGwNT5V5VJ1wzlOqjipxDJRnDJh6HWDnhNQFG6KJtQy
         3Z5k1oOMgvNxxhUZ2GzFgb/2QYNwGaCNWzIHtsCmRp5XuMw7/G5LdojIPUqaDsWStGHo
         IX9larYeKr7CaBZ9yW+CHEdF0hOOhNBKMMVGB5tZ0LM7An7Pwt/0J9f15pypDn83n45Z
         SkrOHxspB31T5rTcGoJSMDnaTNwfzZVHHU+zpCMbHjDmJXfcdRSom9z8qGwFMxJeXy7P
         vIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102263; x=1778707063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qct9180ue/H0QODWWGitx8QQGo9oBwuKWknYkPEnMTk=;
        b=qyoZjoVPVqWodUVIopuEPWpYJBeoI+tEy0nKu04jvaA5owWyp2pXudbjKldmtATwL9
         m28Ryj1bid7woZFuII77stdiRDBeYRSk7VVbghLJ+M5oBuqugnL8v5UCbscydeZGBnS9
         5X1fQDKLIM121Tj0YhRaUdUUrHxrVAx3FmdJBgQdspiGJb2D3Z7Lb+tVFvtd6fs24MOr
         PlXmpYKq0f2Zpa8JXPVbsoQgYg9orGwmjEN7gwLAc8D28paEDCg2QTS5DknAywUvby50
         FAm5GiLbyN2nQH9J3lAWqMruMIzGwb8OjLtncNnBcG88hXfspoT6sfAaylsxCMiS9oTI
         gdDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UDg9jNOptvnqU5X4i6Sihx9D4KdjfAmeGVfOB2tlq7F8SXXTVhZF2/dfWJNa7pKleajLOu1Zk7zOiRkvemqaWXxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7VLfJnw9ofQ2U7COLeyvkVDe6AOHgwdSjPhoscAEaXRDPmg5
	NUopOuybORc3UWJxgr/eXcK8kkEa3SNDYoJ/EM7OlHOFDsbSojHO4EbC
X-Gm-Gg: AeBDieum7HLw6qcCKTUz6T76s+0dDUb38EPJFmMWeW9beTOVnpnPE8LKmSgHY8e8fsX
	hyfqy2gDMhl67OwYFUkeMxXw9+PR9pZzU5Xfo22BA5b7GNZw0Ey7kto5DbaBGOGZVOjfTWv7rA0
	iAG7KlEm+soxZ9misXSR86lhqFsmvp32kH80I6kXzzgkCAcKR9UXxAh3nPvX9rZKVR5VSO9415L
	fqLsk/xirw6Kc+t6usVisVG5eqMTZa6Ns1Lr/m7lKEaRU+QM5q2DMQoRBWjPKDtPVxV+qqIobin
	/fJ/4EnNzidpFAhwk4C+XxkHCaFpz0DlM3hopTF/AWfy5ui+NriFDpopScnJ49kV8xCPgwEkI7t
	LpAGVpMUGL0MZVNn7rfTSEQlvslW0P/dhejGQLfsPiIwISVoT/H4ECp2KI3Z8Yxw8d+o5p3NtqT
	5NkkKu1xV998aWr5kiEflIQ8uiHWQ5VlaSkz6cO30UEOnYZYapNOpGCC1UTp1Cb4dk7yGwBXU=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr45435345e9.10.1778102263311;
        Wed, 06 May 2026 14:17:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530c3a18sm24141125e9.11.2026.05.06.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:17:43 -0700 (PDT)
Date: Wed, 6 May 2026 22:17:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, "Carlos
 O'Donell" <codonell@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, Indu Bhagat <ibhagatgnu@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Dylan Hatch <dylanbhatch@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Message-ID: <20260506221741.44693d87@pumpkin>
In-Reply-To: <20260506221358.55ba5187@pumpkin>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
	<20260505121718.3572346-5-jremus@linux.ibm.com>
	<9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
	<20260506221358.55ba5187@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 22:13:58 +0100
David Laight <david.laight.linux@gmail.com> wrote:

...
> Try compiling it :-)

Ignore me...
