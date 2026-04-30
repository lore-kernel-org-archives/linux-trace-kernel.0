Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBE2D9ECA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562578; cv=pass; b=dQy7vHyX7fZKB7OYwJ6jppXXCN7tP2h3omrF9AWRCLjkkiQI4JPZWay7YtvIF6m3KDyAkKvtbludCCd2OZYOf3673/d7/LjXhO6sAQQLJEHrlvf7wpBq0qBriYTk9+DZNeusr5IwPHl1yra7xaldi/LO+mcJWEkbMxt9l+UJEtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562578; c=relaxed/simple;
	bh=VttgwoB85cht3PKYb8QZ8qtGm3rDTnCCBtygb68d2o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3LtNDPigsdTeDtskEf1iunH97BFiXcGsVRccdR7GXXMweSor/m1Eolu35cl0OgonIgrggd2kKEVjTDTa8DjCuQdHzws7iPTAmfUAqSCYztk6pwPTxqtT9MI661GJuJYA99ntY3puPAdY28px1dqHJ61D700K4i9BgoLuQ66D2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmXKmukP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmXKmukP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so13334a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 08:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777562575; cv=none;
        d=google.com; s=arc-20240605;
        b=QO8hgZpHCvaPsOpbYiHrmYTNfCtPq71PU0qne5hMCgtMSnQtDbpwFIR1qKiuHyt/d9
         w5jV1sHPgG3j6LuYeWpRnQx7Lc0wNpF17+iP4WN0hDPK4QfuvxeDYsCtQ8ARf82S80sW
         vH6iQKEVKZqKo14rvaxNxTpeXDW9Zn8iq1dWJJN+bc64K39GB6CQJpgNktDvWnX6UtcP
         0gR4oKfIupAETrKV8mJpJFeeJDiuhivqPx9fHk5KEArUoeS7VhnEujvMgwcJv6Wl4SVi
         XYwljoctFKH6OJZZ8N3h7NhINYSQJ1Voc4LICJW0R2vG5hnP7vvtV7pmPWAJ5YWyq3mk
         WdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4f2t9Iavwrso0cx79h2X7BZfZ6KB6P9YOcCIqQQB2DA=;
        fh=wokvueOmT7eQAyprzA7KcgeMTbDHaecT9JANuAydhGE=;
        b=DyGhAvYUpr3vR+eiQoJ0dFbxvVkJkiDXkVJhF1Q8HiFrZy1mswWNYYg5S3x+389j/S
         fGbgg5vpmqvjqQ4FRr00XwBBzSwEcXoIUQtsSTd9tWa3KUPzM5glWeXVnCfs8LMuM8sR
         koxkw9g9h/pTwEceq4VPLbAq4oMOBS3YrXeBA0DqWhKJ55eJd9poVlrJK7l+knNPudzV
         gtih0fsvDt/iYiemeXRJu2dxPYVQZrX1mH2Wl0TvCYzuTzfByqN01HE7qwBxxcP6Y9nK
         5AmtN39Tpw0sThyfIJstOT51WiprUJduWGrofKzVuXAly2YQGHIOWQIZFs2tBeYZ8cqD
         Kx3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777562575; x=1778167375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f2t9Iavwrso0cx79h2X7BZfZ6KB6P9YOcCIqQQB2DA=;
        b=cmXKmukPDZsqP4ixXpetZ4lqign+9o9o0cdBRlAmOQWZZlx3bhzMzI+APPksDnmMEw
         /+HcmsTiUEUFLkYhuHNIHDs4ZfJUmbxvtWyUaYdW5PCLppfLVO+HFOVPs6ACDYeLgOl7
         DxW9UsRXfw4+GzALguJa55pQdLaEwR1rN75/hvyQzHfv/3Q/eQUtGcdB7oOEwKCR6hjX
         PoOzjfN5sbkBlJ4342XtIyPcun2G3OaV877bWPsqwkWQRN5nsNGy60NG+0Cy4c4w6aeu
         QrkUk3myPpWfOS4NOeu2ZbzlEpHRQBrRO4q0gUZNCAdWhRr15CbZ2nr550EX/6FQNFuW
         4iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562575; x=1778167375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4f2t9Iavwrso0cx79h2X7BZfZ6KB6P9YOcCIqQQB2DA=;
        b=YMWqZ3ehbZxhummwL57ZOEp2MoixC+kNdKcX1RyOPEAIBjWmbiCUZYtuEiMIhCTDjY
         gOUYl1LZh0douM1OYA6zeJ14Pkly3hAOfKt0TAXB4o2lX8C5yc/A60fxddwhro2Kstnb
         e35KBMB3uFdYLRlB7PHvnP1v68MDMVl7YyDJJOcD97to2nx6lrbxBOiElZPdeKlqBzH2
         GgXPZbIbdeYszlFHOROOykswcA2WqPN5KVoDWC53EiU2/JXVc8nCzH6svQtJxlIHgMdp
         imx/lsV0Tm+Gb+qxcMTuGA5MzWoISrDuGubRBMIOBzOyZ6++PSoz0Uq6rL6Rrsq1o22Z
         m4ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dM5draZifqtkwZUxRMGOOa4VAlqt5IJs8WlmMbWOwBmzx81KAErbvTVQYSNMkYDEWLVKpY3VRmau77DDrLnhMbBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KNFvj4cPlAnP76D1JxoL65h1GLLXYbWFWJSKoI2FAIu6IMol
	cdoW9b3aV+QIQN8+brcFWnd4hwkwaUiHnwPDUvOAdIzOhOo98IzGGBXk0YY+ory6OvTXb2zCd82
	Ma+QlH6cyrjGXmuuUoTgqQU108a4Yq3zo+h2OKBZ7
X-Gm-Gg: AeBDiesqeG+FghytNPJTht3przbGm2dnwOm1nHp42IDrLS6dJAvDOycgV+YfEBY/NrU
	3GEOabMEQ2CA5Sa+vBIa88Es9381N7TY6mEEZdi7WBnRcv3Tccsp7daWCDHVlLIkvKUaPHA3gE9
	MRGqJuPoxhfuqbvnNMMSthC0XEkC3LQUbTDT72B/U0O9jJSf0m2ZnrERQIPSly7VXGeGswD1WGj
	eb1ovI2jAOR01cut7IXR0NVoQTx7EWxan9n0BFF6hvI58TDKQRbUfobeMoF5nBapa8No3eXN/JP
	P6uaWwa38GLLGUE0OT+VRTzx2hNJIxvNxmEHA7SIexH+ev4xVgTJXqvohQ==
X-Received: by 2002:a05:6402:3241:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-67b4e8ea06cmr58179a12.2.1777562574533; Thu, 30 Apr 2026
 08:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429131522.4049054-1-dtominac@cisco.com> <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com> <afJz3l6435DHLorn@goliath>
In-Reply-To: <afJz3l6435DHLorn@goliath>
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 17:22:18 +0200
X-Gm-Features: AVHnY4IXFcsVkK3lFxWPc3mkzosN0e9A_ZuO_cu-riyBEoDL1P4-BpVJGbycfsQ
Message-ID: <CAG48ez0mwkHz=4+PoLv_VmYrQiPqkSQqCSo=3R-ztrQ2zAHUwQ@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across MADV_DONTNEED
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)" <dtominac@cisco.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, 
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 11:11=E2=80=AFPM Daniel Walker (danielwa)
<danielwa@cisco.com> wrote:
> On Wed, Apr 29, 2026 at 05:24:25PM +0200, Oleg Nesterov wrote:
> > On 04/29, David Hildenbrand (Arm) wrote:
> > >
> > > On 4/29/26 15:15, Darko Tominac wrote:
> > >
> > > > uprobe infrastructure does not re-instrument pages on individual pa=
ge
> > > > faults (uprobe_mmap() is only called during VMA creation, not on
> > > > page-in), the breakpoints are silently lost once the discarded page=
s are
> > > > re-read from the backing file.  The probes stop firing with no erro=
r
> > > > indication, and the only recovery is to unregister and re-register =
the
> > > > affected uprobes.
> > >
> > > Right. Don't MADV_DONTNEED uprobes, just like you are not supposed to
> > > MADV_DONTNEED debugger breakpoints/set data etc. :)
> >
> > Agreed, thanks.
>
>
> Shouldn't there be some sort of compensation or notification for this, or=
 is each person that
> hits this suppose to just scratch their head and send a patch that's reje=
cted?

I guess we could add a pr_warn_once() that warns when
madvise(MADV_DONTNEED) is called on a read+execute file mapping,
and/or (as David said) add an explicit note in the madvise() manpage
about how that can interfere with software breakpoints and uprobes?
