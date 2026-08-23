Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AD355803
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787519052; cv=none; b=tu1toUyTlQW595s25zXiUyNX6nqWZ57lhg92CO2WQ5wFn9BRo8D8ch89OHlu7Ix0fdwxuG2o84CHZEnmhMi0pnFj92cV2E5Ea+r3VLwxooijauAee59szRcpO2eQxY9hRWS7bANXAhOFicYujFq+skCyFrFdMMnBN5QIVGYxn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787519052; c=relaxed/simple;
	bh=Y5VxSwmuQ6ztS1MLxHRfHBUyhAy2w+d0ivs0tkUqY08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz4RqyqwK07kc6lUf6sCmNvq4kQP52TbmNZtt44sN+OlbgHQJtUbLDSR2Uk7l8904Ea1/53DkNtAt8v3PKmlQO7A5OIe0seCtoCHIb+6hEHAFSLUUvZ90RXMSOQv6dqer/RvvNDp9lHhISKUX/4E/DOeHPzJp7MpwwzfmrUccqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGWtU1r1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGWtU1r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6671F0155F
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 21:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787519050;
	bh=Y5VxSwmuQ6ztS1MLxHRfHBUyhAy2w+d0ivs0tkUqY08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SGWtU1r1O+/G6w/iQF/Am3SuKXqCK3ZinFSW5xmAN8aUfMvGFZ+x5FWOvAa0Io8h/
	 9f5VppfNfuPpISvprGPw3q1pUYiYb4HaFqNMtv7ACBaANPtEAmoDEZXiahH29QAkcb
	 9LEk4EyKKh03b/MNF3mhJpS3jNC1eEmgv0US2yWmE6r80gOCYwPou1qD+rwMEsJr1H
	 4LB0MO6MUFpbSq2Kg4AF1I5WxUqM7kUqNF+GJtIBJCxOg3MjJNT8eObfMLYq03QfOX
	 E7o2ATBWvHB6w3rXnbfBk5FiwNEIynpqY+HPY8/PzGuhCfji2qC0P/DeaLJoJPHbQv
	 3XCke1p0vh8NQ==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f032b47e3cso17924846d6.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 14:04:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqJcNmxpIaoqTMH5eNw76Xl5O8fWKk4XtcoLFUfhiyV+cnXYlIAIiz2jN52P3KoOtdTg4j0UtwNT6xklycEXVMpZzs=@vger.kernel.org
X-Gm-Message-State: AFuF++k5Ob7m2AFFlWc4uKIJ78cqKUJkkG571XTEUx//DXDRS6sh6cjj
	u7eLgt6S1QwsSrRJYEM2Boekb06OMObPz5hVM7Cp/4Qe0MpuwGzxiVg4jqN0/IsIPy/9vcI55TG
	qM2Rk40cDof6nS6cRiw2CWnuiPUnwjr4=
X-Received: by 2002:ad4:5cc1:0:b0:90c:5947:7e60 with SMTP id
 6a1803df08f44-90c80c15daamr170758646d6.4.1787519050081; Sun, 23 Aug 2026
 14:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org> <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 24 Aug 2026 05:03:59 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z1FHFOggOfq4V_ikdrNNmiAyDTdUaq6=Svw=MSNJODpg@mail.gmail.com>
X-Gm-Features: AcwNN1XAA5UHMELIWABqTde52FJDm4K7QaHzff4fQOng4mfJiplIHcLVl25NsMI
Message-ID: <CAGsJ_4z1FHFOggOfq4V_ikdrNNmiAyDTdUaq6=Svw=MSNJODpg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm/gup: move gup_can_follow_protnone() to gup.c
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

On Sun, Aug 23, 2026 at 8:17=E2=80=AFPM Mike Rapoport (Microsoft)
<rppt@kernel.org> wrote:
>
> gup_can_follow_protnone() is defined in include/linux/mm.h but only used
> by mm/gup.c.
>
> First, there is no reason to have it in already gigantic header.
>
> Next, the upcoming refactoring of userfaultfd flags will make
> gup_can_follow_protnone() depend on userfaultfd_k.h which would cause a
> cyclic header dependency.
>
> Move gup_can_follow_protnone() to mm/gup.c.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

LGTM, thanks!

Reviewed-by: Barry Song <baohua@kernel.org>
