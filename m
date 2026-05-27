Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B338B7BB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910598; cv=none; b=gLW7Q6DELk8YDNMzIVcSuzRt6vC6aCGOknhehMEW8q7jfl9utey+bxocwiJmJYbNDBTaooIi5tCAJAKuyQk4/9Da/tpWz7sr7S7wYe0qtU+0s/4g0eSZhre/oE+H84P+3lhA2CF5bsyojhUgjHwnG8r4/mbqcZJPbkx/gjAJcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910598; c=relaxed/simple;
	bh=akrU2NIo/LkJmp42HPsnTzcbW+43IzEJEPkm1ct7y4g=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nAZogXWCoED7TUYAnRcpnEPsc25d61zxMy+QSaeeMQar+O28sC1APTC2WMpqsOYaueVxlntLaN4hye4/eh3PhnX/FgU5WeZMdCAmUPhb6sN/YX8fmgJJlxHi3B21RcgCgmflIsbhcTl3S+9NXM+ISpHCZmjq719s/zTiQvJr2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkDWbzYd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkDWbzYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779910581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/B25QGs4mVlKSh4yzEmSBjrF3tS3ZQO4EEI3fBX3AY=;
	b=bkDWbzYdmmSCkAUu1/khTAVY1dRciuMJkEjuIu4wNKLPEsVXT949sD+zG4FhrsJeVFvljv
	eTriVy0srMQISsieQT075z095AJdQTUfub/svp3YfouOuIM4MlMP7PexIbLfBbazdSpf6f
	VbHbb+tOzHqJ5w0aUUjRUUTzRLTkxKc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-sZmDpwJNMsOtswTsuePctA-1; Wed,
 27 May 2026 15:36:17 -0400
X-MC-Unique: sZmDpwJNMsOtswTsuePctA-1
X-Mimecast-MFC-AGG-ID: sZmDpwJNMsOtswTsuePctA_1779910575
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FE1D19560B4;
	Wed, 27 May 2026 19:36:15 +0000 (UTC)
Received: from localhost (unknown [10.64.240.63])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE7A71686;
	Wed, 27 May 2026 19:36:10 +0000 (UTC)
Date: Thu, 28 May 2026 04:36:08 +0900 (JST)
Message-Id: <20260528.043608.1154306528199981709.yamato@redhat.com>
To: peterz@infradead.org
Cc: rostedt@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 akpm@linux-foundation.org, masahiroy@kernel.org, geert@linux-m68k.org,
 mmarek@suse.cz, hamo.by@gmail.com, sboyd@codeaurora.org
Subject: Re: [PATCH v2] scripts: Have make TAGS not include structure
 members
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20260527162914.GH3102624@noisy.programming.kicks-ass.net>
References: <20260527121144.08a1f676@fedora>
	<20260527162914.GH3102624@noisy.programming.kicks-ass.net>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 0KwKDE5LJlvuXRJxtosKo7Shhpxy0Vy8gRezK_33TIE_1779910575
X-Mimecast-Originator: redhat.com
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] scripts: Have make TAGS not include structure members
Date: Wed, 27 May 2026 18:29:14 +0200

> On Wed, May 27, 2026 at 12:11:44PM -0400, Steven Rostedt wrote:
>> From: Steven Rostedt <rostedt@goodmis.org>
>> 
>> It is really annoying when I use emacs TAGS to search for something
>> like "dev_name" and have to go through 12 iterations before I find the
>> function "dev_name". I really do not care about structures that include
>> "dev_name" as one of its fields, and I'm sure pretty much all other
>> developers do not care either.
>> 
>> There's a "remove_structs" variable used by the scripts/tags.sh, which
>> I'm guessing is suppose to remove these structures from the TAGS file,
>> but it must do a poor job at it, as I'm always hitting structures when
>> I want the actual declaration.
>> 
>> Luckily, the etags program comes with an option "--no-members", which does
>> exactly what I want, and I'm sure all other kernel developers want too.
>> 
>> Create a new "no_members" variable and assign it to "--no-members" for the
>> "TAGS" case and pass that to the etags program to remove structures.
>> 
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>> Changes since v1: https://lore.kernel.org/all/20131115093645.6dc03918@gandalf.local.home/
>> 
>> - Use a no_members variable instead of hard coding the --no-members into
>>   the etags call, as that can break some "tags" cases. (Michal Marek)
> 
> Yeah, I often use member tags.
> 
> The tags file have a 'kind' field, what you want is for emacs to order
> on kind and prefer 'f' over 'm'.

citre (https://github.com/universal-ctags/citre) utilizes the kinds field
of tags file when soriting the list of definitions. citre runs on emacs.

https://github.com/universal-ctags/citre/blob/master/citre-lang-c.el#L28 explains
the parts of heuristics used in citre:

;; - When the symbol is after "->" or ".", tags of member kind are sorted above
;;   others.
;; - When the symbol is before "(", tags of function/macro kinds are sorted
;;   above others.
;; - When the cursor is on the header file in a "#include" directive, the
;;   header file itself, and the references to that header file (if tagged) is
;;   found as its definitions.  References that uses paths can't be found.
;;   Also, file names will be used for auto-completion.

I use citre and ctags daily for reading kernel code. Quite comfortable.

Masatake YAMATO

> 
> The alternative is switching to use emacs-lsp, that way the editor knows
> the kind of symbol you want. If you're on a function call, it should
> only consider 'f' tags. Whereas if the cursor is on a member deref, it
> should only consider 'm'.
> 

