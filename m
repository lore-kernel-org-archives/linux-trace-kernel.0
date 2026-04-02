Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96336C9CB;
	Thu,  2 Apr 2026 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157983; cv=none; b=jEAg5Tm6yaq2VoFon1VYQvrF1LdcN0iaWT+8X6k/RSyCaQPf+PfQwutNL+O1YdEAmN96JQZoFuqEmnLDVD+nnv7Wz5t+vTsohh9NJcwJUpSV0Nbkf7/ktzQ5ZXBuEZz3ENaU1ahp/1LV2NXa1DiQSkc3ODn0Un1yntUNI+FxA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157983; c=relaxed/simple;
	bh=XLkaYuwC8TJumKWLKI6Vqdpwwz2SiUWTGMJT6mO3V9k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P03TeoQzPG3/itdKENCWmQvRb2q79rmW4FlEPyx9lcpKrLPvOrI/eeVlpgFQl7UN0enX/+X/6AYlnu7ldOqbtYFeoK6bHS8DYpmP+0hbgxGz2rQtCNqCU97sk1V2XHVpqEN7SAxi1pFL0QQtXgSvAYFjOaPeR48DC7a3kay/7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VJmlyU2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJmlyU2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40095C116C6;
	Thu,  2 Apr 2026 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775157982;
	bh=XLkaYuwC8TJumKWLKI6Vqdpwwz2SiUWTGMJT6mO3V9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJmlyU2fMvJ0khCoy1tyTA7o/BVvGJ9czzpOxX4I4bqpdJtlryV5k/ynLUFFpZkha
	 gMc07NJW1hL7Bub2F4I1a4k1Qz3ZGwd6bBlsuD1SSsPJYsSDtyw7f7Z/oxcgdcppbR
	 aUabFPTvkOy2z4MQNc/SpSztOnFwEL6XHe61Nkrk=
Date: Thu, 2 Apr 2026 12:26:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, linuxppc-dev@lists.ozlabs.org, Harry Yoo
 <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Michal
 Clapinski <mclapinski@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Srikar
 Dronamraju <srikar@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
Message-Id: <20260402122621.566be08b7d16ba082371b5a4@linux-foundation.org>
In-Reply-To: <6a5f2139-0ff8-40b3-88f9-98d2ea020d6f@efficios.com>
References: <20260319233745.GA769346@ax162>
	<abzKcGiRSR_E8lLN@hyeyoo>
	<7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
	<ab1J9ODkX5iChu-C@hyeyoo>
	<7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
	<7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
	<h5qax9x2.ritesh.list@gmail.com>
	<20260320192153.759d6fec57f04fb653a0dac7@linux-foundation.org>
	<6a5f2139-0ff8-40b3-88f9-98d2ea020d6f@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Apr 2026 11:30:53 -0400 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-03-20 22:21, Andrew Morton wrote:
> > On Sat, 21 Mar 2026 06:42:41 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> >> Looks like this is causing regressions in linux-next with warnings
> >> similar to what Harry also pointed out. Do we have any solution for
> >> this, or are we planning to hold on to this patch[1] and maybe even
> >> remove it temporarily from linux-next, until this is fixed?
> > 
> > Yes, I'll disable this patchset.
> 
> Hi Andrew,
> 
> I have prepared fixes for this issue. On which branch should I rebase
> them ? Do you still have the HPCC series in your branch or should I
> send it anew ?

Cool thanks.

It's best to do a full resend after -rc1 please, presumably against
mainline.  Show reviewers the latest version, refresh memories, etc.

