Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD7303C97;
	Thu, 13 Nov 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004081; cv=none; b=HcuUrCbpffwzvZ9eAOafAVW4//CcZEoZ3UcB4BKbnUd1a20TjnNVhQLapjfgaGa6QvMTDdF6pSAgsziL+RALuXQaRJ0oy1dy4CZntiMRSHRPeda0If+U1FUhKAVOxICb8ysx5OveKwUge693Ut+6LzvLY59B2finpBVj4EAZ7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004081; c=relaxed/simple;
	bh=iyUf6OZ1+CNOa2blcdUSJ8Zb9KDuJ7WA8pXMK4JDQjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL7jgpMdJU4Zj2BsVH67VpwYia10ofLi9VG4FdmynlGkbhqi+MiektrPVZQianAuTkM0/+v6s2Esq1/1eyOkd5OWZhmBV1y1uEUxepEf1svUo11WL8d2Kl3nXkcld/Eo6ALi6WQ2hD7NPbp5DbN2OS6wahMB+7Mg9TEdAE5sMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E8B5B5AFF1;
	Thu, 13 Nov 2025 03:21:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id E70466000F;
	Thu, 13 Nov 2025 03:21:14 +0000 (UTC)
Date: Wed, 12 Nov 2025 22:21:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Donglin
 Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251112222113.74fbff01@batman.local.home>
In-Reply-To: <CAErzpmuPY3_b9LCdeG_8H4hCm_r+4rhzxfwVf04H0jnxBdE5nQ@mail.gmail.com>
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
	<CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
	<20251112103804.4a43591a@gandalf.local.home>
	<CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
	<20251112210236.07deb6b2@gandalf.local.home>
	<CAErzpmsn-uys3VdchF_CKBPUQT+328wtaKnbufoDi-o9x7eHaA@mail.gmail.com>
	<CAErzpmuPY3_b9LCdeG_8H4hCm_r+4rhzxfwVf04H0jnxBdE5nQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E70466000F
X-Stat-Signature: whr7cfzt4oxseaa9iotz1ty3ozuyiu85
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198YUUjLGfGHWnguovKmH0yR8plVE7KvgU=
X-HE-Tag: 1763004074-309902
X-HE-Meta: U2FsdGVkX1+d/6yvkCI9qdnOjGszMjtN5ozSbNgvtYc+izlnP0iyevM7W6sHjpJE07YBAYquhA3BQpJdVgdSanIfDrBGgS666u4Jh1cAz5uWd9/iXHosa2n7ZEhNBMcbf0UJWrTjjbTab7JHTVkiD5qIR8GE3yvgozm+bGdULm4gNR1RlpxziJEvSfcdmCpyc2COVDGr4HHfxm6TR09VPylIuAJuAxi9XZDFmgZD1esqUUyXFTB3bjQgV3oewttOghNl4sMpQvAkMT9MlGpiwnVFFM6hjhXE+k78J2QlCbLQDVRkPpfJyklxQ4k6lq21Dv9QZA0LBzW/8bzOglaIo9/HekHUGr7C

On Thu, 13 Nov 2025 11:01:15 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> > Thanks, I agree and it indeed introduces extra branch instruction and
> > may introduce more overhead when using indirection lookups.  
> 
> Is it necessary to do the same thing for funcgraph-retaddr considering
> that it checks the global tracer_flags in the graph_entry?

Not yet. There's still other flags checked. There's other methods to
help with this (at least for some flags). Let's wait on it for now.

Thanks,

-- Steve
