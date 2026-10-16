Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2945EF49;
	Fri, 16 Oct 2026 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174029; cv=none; b=bUmDFsGoxhVCWvbDvyPswFsYYvF5FH44y/mZLSDn1y6/JhxYXvWxQDTXy3LKPpmody4aVG2Ue6BsUI/U0f9aNfpXtTZctx1JeqG2VvhieGMOPAmTTHxT2Ud7c3PuY3rr7jRAURRNEbv7rEatg2ocsmQrfWWndEc4ByRvy05inPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174029; c=relaxed/simple;
	bh=h5MP+NM2FAbrN6/K3YPY44fR21Dl23DsBucbiIamOhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD7rriLkGQ9GrJtKGO6QGrxGHdI/NyPhtiSDdhdtzrHaCGrm5Si0zTn8JF2c9m26wn30VaAMXDKOs9zjkduOf7YagGaZ60kdTpxbSklmVreCNEsEBcoX91R8ozazWybNvaaozeG0KAVm4JLWQDjVPiYAEQTTmgIaWtjpeOnKsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=CzTjeuqz; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="CzTjeuqz"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 197A740315;
	Fri, 16 Oct 2026 18:07:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3FD7A17;
	Fri, 16 Oct 2026 18:07:03 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:07:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: speed up module enable by binary searching
 module symbols
Message-ID: <20261016140701.0756b893@gandalf.local.home>
In-Reply-To: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
References: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k56fjinkqm94ddr7xjtz6b9td75ohqxq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3FD7A17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SeseBSLO5GSSozcy1flUClF7mQRxlaDg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=gYXBz5ATu/ejHCOJAzVgSll7icTlWgUKxKvv+/AY2sI=; b=CzTjeuqzLkP7/uYqxzcMRgHHlhNRQPSJhmO6J/8bPuskhom2BSNSJTtwS3fq0vArkZrmhQxpUBr+OmqfDFUxiF31j46xdcGqa5mBYYd4aIpw8nrZaT77AdVoHWn2KmMQ6qBZqwvHj8Nnz3+CSJjoh7D6Fvaw2WTnaQ+Zk5HMLIk=
X-HE-Tag: 1792174023-230851
X-HE-Meta: U2FsdGVkX18VXk3ZG6EEGN1B7C79Kcs7ZqVxPNliV+EyEWD3pRVFqk4ORuWT/aJloPX0DXI/R1GTBuj4xz0Y+Ckk6aS8t7YksRoTztBdcASaZu98X4T3YFPXBWbvPd6SDbSenZBgEFAfFByXjCdoTXFUgniNeZiNez+BsvT/zeUQdJyFbwVapNJ4W/u7waRC3ERVnXlEzFCLF3J6/COQ9i4HxeUBUSPQvFVEbQ7tFcGYx28s6muFfPOYfI7rYeMrOwIj/Ri38VfUsVRHPQ+S6Kf9rAjpLmUXKo8JIvt/3EEpS1E/hiAi4jMAUYQpPfHt

On Wed, 16 Sep 2026 16:27:15 +0800
Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

Hi Yaxiong,

I've been traveling since September 14th to October 10th and my backlog is
very long. Unfortunately, I will not be able to look at this patch until
after the merge window. But it is not forgotten, just postponed.

-- Steve



> Loading a module with many functions takes seconds, almost all of it in
> ftrace_module_enable().  amdgpu modules stall for about ten seconds, and
> disabling CONFIG_DYNAMIC_FTRACE makes the stall disappear.
> 
> Every record is validated by test_for_valid_rec(), which resolves its ip
> through kallsyms_lookup(); for a module address that ends up in
> find_kallsyms_symbol(), which walks the whole module symbol table from
> index 1.  The core kernel instead binary searches its sorted kallsyms
> table in get_symbol_pos().  So only modules pay, and the cost is
> quadratic: both the record count and the symbol count grow with the
> module.  An amdgpu.ko from this tree has 17282 records and 55332 symbol
> table entries.
> 
> Fix this by collecting the addresses of a module's symbols once, sorting
> them, and binary searching that array instead of walking the table once
> per record; a loaded module's symbol table cannot change, so the array
> stays valid for the whole pass.  What comes back is what the linear scan
> returned: the same entries are skipped - SHN_UNDEF, unnamed and mapping
> symbols - and the closest address not below the base of the record's
> memory region is taken.  Whenever the array cannot answer, because it
> could not be built or because no such symbol exists, the record is handed
> to test_for_valid_rec(), so the rest of kallsyms_lookup() still has its
> say and no verdict can change.
> 
> On the machine that reported the stall, modprobe of that amdgpu.ko takes
> 12.242 s before and 2.870 s after, and the time spent inside ftrace_lock
> drops from 9.368 s to 1.585 ms - 15.195 ms if the price of building the
> array is included, that build being 13.6 ms, 0.15% of the 9.37 s saved.
> The array costs O(symbols * log symbols), it does not grow with the
> record count.  Across the 74 modules loaded at boot, total lock time
> drops from 491 ms to 2.33 ms.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
