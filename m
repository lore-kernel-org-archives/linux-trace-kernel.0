Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DF3AE715
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787519664; cv=none; b=lehv7bN4M7DkRpuA+gcWjFfJqjXhZfGX9dMJmYNSBH6C/l9Rysvva8cgrBj4EOAmZnncaST0EEYj36U/nqnvuKOuSpHYnVj/VMdOfncG0gVsTOVm2/i8gS5pRLJWr4SF1muvXHaYqRxfgp5dFSyGfj7lbHg+a2admGFTexmnrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787519664; c=relaxed/simple;
	bh=5aIk5hjqNt5oNCOWt6NWdUPn77WlZIYMgpDkKjeT4gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPSGya4x4jqhZtyatKNbZ89giGtLXebzesSd3vkv2dweVPPD5f+SvUYtCGAg9kDwwTwpF4FHRVKCZescK2zQ//kHYpRn2R6ybcfIO5Our2BO7UAGCSWXNaDetr1A2rAanokkPIIe2GR/+A/94rTM8ShxsFoYq0fJ9tSKZnnW5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhj8IXPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhj8IXPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BFD1F0156A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787519662;
	bh=5aIk5hjqNt5oNCOWt6NWdUPn77WlZIYMgpDkKjeT4gI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rhj8IXPa8+Foj6h4ON2DpulSKlWKVqUoCZ0tUxVdjkGMS6mDg62lftZBZsInlJdiY
	 9GpDcXsON4jAhZZ4UVxL0wFXACUuPm/gwI68BirTUDvAMlIkRrVZyk+5cvZRRbiXOj
	 mIMsP0r+NQ000h0QPDX0BlQLFJzRlaVf7DjRJcLayjputbhR+RqVLoXIA9cv3UeY6T
	 g+7X16+0DrTTjEBsO2HzSzyEX6cN5E+PoKo+V4ZVRro0mQTcU+LVyeyHH2bvHkAs89
	 6EyhV7sl/DZ/aqY81LkD1Rtdna0ZiI6SiNEZDZrVJ3Z/8iludEorqg9pW2Qb1bz9gR
	 MY6ogG7MytaIQ==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0ecfaee7so18450231cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 14:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqHpNA5BztTuHQE9knKqrJ7sF1OYTb4N5uf0qvFD3PLZJOcjtZv113cRWkfarGljDpDEmGus3lpKWELxgGgRmnS9Uo=@vger.kernel.org
X-Gm-Message-State: AFuF++m8k69wWfzk6ClIoPu9/lqh92M0qEaODOU0g0thzi961tGlm3BL
	yfP6n8Pvoikuo6/X7F9bpcVPm7BTIZJapgreH5cNcU2xnxyMNTzWfmUE3hD8/+0qjsn7RZRNUYE
	OoS6v82RrTR/D2Hvsyc4szY3l32vMQbM=
X-Received: by 2002:a05:6214:318d:b0:90a:807d:3668 with SMTP id
 6a1803df08f44-90c8f941e02mr144419456d6.7.1787519661887; Sun, 23 Aug 2026
 14:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org> <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 24 Aug 2026 05:14:10 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w643aN5OY5RqSwPy5V=ost8fGyaODGyGQj4c_Q+LYO+A@mail.gmail.com>
X-Gm-Features: AcwNN1VurWkGDFr7vGNUR0UHyLbUPFfOak-4q4LksN87tuQ5GQ8kLbP5vUnF-Ks
Message-ID: <CAGsJ_4w643aN5OY5RqSwPy5V=ost8fGyaODGyGQj4c_Q+LYO+A@mail.gmail.com>
Subject: Re: [PATCH 3/6] userfaultfd: use userfaultfd_*() helpers instead of
 open coded flag tests
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, 
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 8:18=E2=80=AFPM Mike Rapoport (Microsoft)
<rppt@kernel.org> wrote:
>
> Move userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected()
> ahead of uffd_disable_huge_pmd_share() and uffd_disable_fault_around()
> and make the latter two use the helpers rather than open coded VMA flag
> masks.
>
> Convert open coded VMA flag test in mfill_get_vma() to userfaultfd_wp()
> as well.
>
> With every user of the per-VMA uffd modes going through the helpers,
> their underlying representation can be changed in the next step.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>
