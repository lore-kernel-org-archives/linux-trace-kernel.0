Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DE377575;
	Sat, 30 May 2026 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780181862; cv=none; b=E3yNn2bcc5/bPb5sAkhyfFCd1+Fw6LqbPqj89X+gxKukGsVSO5nLw2W7fEfYUb/1zgkCdO+P5PPX6ERxh3y4AfYJ6vf3cRuUfninjty68UAkfv4VL8FxHWCRdm8gfCu00Hv8KcuiShIFgu7DBBnJ825nfxi8KHKHD+LCCubNh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780181862; c=relaxed/simple;
	bh=A1xBf/qMyS3NLEUgQa90BrjDLZ4ePfLGqm/jIOSkqMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfnKKb4XsJ7z5HqcML5KJzVTpU9ppa2Bmksozq/aAfko46gMWTRgPdvpXBKqqKj+hF6xBXExpqVZXnXL8Akf3RbKLN2hHK9hZKuMRndFIRhb6x4/xZoB0JS8i7Ud4xOZ1iRIcHZnPBEHfGEWQPR9ZFu7XTm9o8GdQkuDomj7/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 8376BC0249;
	Sat, 30 May 2026 22:57:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 53F9A2E;
	Sat, 30 May 2026 22:57:31 +0000 (UTC)
Date: Sat, 30 May 2026 18:57:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Eva Kurchatova
 <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, jpoimboe@kernel.org,
 samitolvanen@google.com
Subject: Re: [PATCH] tracing: fix CFI violation in probestub helper
Message-ID: <20260530185730.2928eb13@fedora>
In-Reply-To: <20260530221921.50d958cf@pumpkin>
References: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
	<20260528164902.1bb985f3@gandalf.local.home>
	<20260529200826.GO3493090@noisy.programming.kicks-ass.net>
	<20260529195134.37d4f5cc@fedora>
	<20260530221921.50d958cf@pumpkin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gacuynxz1q7q5kwfa13nrsnaszkh1ryn
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 53F9A2E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18V7n7Tl0HF7qVXL1Fro69wciUnCjs8I3k=
X-HE-Tag: 1780181851-430160
X-HE-Meta: U2FsdGVkX18wfwU6sPE9lU/0jKQ7N9Y0VCpMTPdouJrLFY24KtvQMx6v60SRP1iMH3t75fZUKmZccBl7UwTnl6QdqhkI8MWhjxVMKNLL5QXaI9xtIM0ijTKWm9A7DClSehhde1v39PQn8wOfU1GudpkPwGq9JZw3FKFKQZyVYzunDPa4svC20eHT+yWP85xalp5C0kcgs0HQwqIfAFnj/UcxQPgYLN5PIuZ29SibPp6/AAIjq2HzOst2LNZMlAqyxeKaWbIL6jbXeKhNYd5PDP9EF1XcVMz5RATPtMSkOFvX0TE075X2pguKIH8snSoiq20YvTjMaBeffnvNnA8ZR38gOgMJim4/

On Sat, 30 May 2026 22:19:21 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> > +/*								\
> > + * The probestub is only used for tprobes and not referenced	\
> > + * anywhere else. This causes objtool to think it's not called	\
> > + * at all and will add it to the seal list which will remove	\
> > + * the ENDBR causing issues if a tprobe is ever used.		\
> > + */								\  
> 
> Isn't the sense of that all wrong?

The above is still correct. It just expresses what the probestub is
used for.

> Maybe:
> 	Annotate the protosub 'CFI_NOSEAL' to stop objtool requesting the
> 	kernel remove the ENDBR because the only references to the
> 	function are in the __tracepoint section that objtool doesn't scan.

I do agree that your version is a bit more concise.

Thanks,

-- Steve
