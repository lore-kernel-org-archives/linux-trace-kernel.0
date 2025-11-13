Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E7B13AA2D;
	Thu, 13 Nov 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995718; cv=none; b=RoDAIk/1Oe3jq/e4e9ywDelGAu7wYklzpFemrdX80LvBgSD62uRH1L8YjEt2pf5OhzGA1sEdmfwd33VFQCrG00W+WjqOT2ceR6tKJXfvKKUoh2UFH9anQ0mp1VBhEOcUsq0wS6eFcbydLKvcxrf64xOZbXJkox3OkcLAeK+Vm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995718; c=relaxed/simple;
	bh=NE/b0gfxO5skpL1fTcBB4eKJwaCUiVA8GzVQHjJeJ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YM0iYfdiii+MgILUKysBm7Xaf1POfTr266xJuhTc5aFNFbYl3vH8OQ0tzmAlZ6EbnMODuuVYSHM2oesoSJ93Tfr6Givznp5+222MuvBhZ4AvXbc3rQXNA5vBpYlaWPyg8CSpRqd4/12JZtUuyVeKsTYPuf/CsWqEnw9AjIjDnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B79D44D0EB;
	Thu, 13 Nov 2025 01:01:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 939E22000E;
	Thu, 13 Nov 2025 01:01:52 +0000 (UTC)
Date: Wed, 12 Nov 2025 20:02:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v4] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251112200206.73222469@gandalf.local.home>
In-Reply-To: <20251113004526.1129666-1-leonylgao@gmail.com>
References: <20251113004526.1129666-1-leonylgao@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 939E22000E
X-Stat-Signature: pit31s6zjcxmiogkz8r9nzffrmy7k3hr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19S0oi0Zng4Ulx/SCYHm/gqnLYHU2lnNlA=
X-HE-Tag: 1762995712-858544
X-HE-Meta: U2FsdGVkX1+XhF2a9wpA/nS9qFr8mu2+uQZSYkFI83HhnOSMZzzCmOz7kI1beHobHkPfXE9rwmXBgkoIPjQJM25rkd0R3rDkzG9zHIUTY5j3R8UK6IET35R79hhvuCFIUaMLj2Y3w3It85UCCuOGWFJ/ZQrf9iRBNfRZ80T46UFEzNbTRPRm6KXAYC4Hc00XU+w3Pso44OJTuCLHCSKKp5Zgl2Abg+8Y7icDAcu+8WUsU7kcWWylIAu55R4jbMpJHfM6hCtfRSYBZyUk9kQ1ubkA57MoAVfNR97ES0QbZze/IVs3mFC98g5RkTibNh+e8IBYO7aFO4mmrg97+jE7zRxQUnFB+ITNhs6lu604ecQZQPc3FFSj+A==

On Thu, 13 Nov 2025 08:45:26 +0800
Yongliang Gao <leonylgao@gmail.com> wrote:

> ---
> Changes from v3:
> - Fixed patch format as per feedback. [Steven Rostedt]
> - Link to v3: https://lore.kernel.org/all/20251113000252.1058144-1-leonylgao@gmail.com

I already pulled this in and started testing it. No need for this resend.

-- Steve
