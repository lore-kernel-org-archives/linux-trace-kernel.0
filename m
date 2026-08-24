Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620136F434
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600087; cv=none; b=faRtt4/MV82fzK/Bh3Yv8q75FsAtbb8DrGJhEmWzjvM1ecT6Al7CJL/NP94conPihp2Ku0rugQLC9aAbT/LZMPGyyouopXzVjDpsWfJL2ASf66SBg6Pj8Mnxp+564jXTiVgWp3rdUDsiPNr6+f0trSgzFOryA5zMxRvz42t6ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600087; c=relaxed/simple;
	bh=l4fYMr0Thpsi8CFwiKKbyyqG1r1E+xVcO7ed2HwA5BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tp0TyOsfzOBSjE+q3L0UST3VlseRSSZtdfbQKbkMyS5nJX5N4NfFDLJAMkh7nsRNhrQ46yofLol+R0TDlxu3H4EZdtzhfJzrOS+0AEStHTh4kEtlNNKlvSeS4OdGINXaHgeEPB95cEF4q8FpioS2wB3LTVSLG7F2prNZoWlSpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=hq7xNGb1; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="hq7xNGb1"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 06EC240256;
	Mon, 24 Aug 2026 19:34:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 6F85220027;
	Mon, 24 Aug 2026 19:34:36 +0000 (UTC)
Date: Mon, 24 Aug 2026 15:35:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: wen.yang@linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] selftests/ftrace: Walk up to find
 test.d/functions when a subdirectory is passed
Message-ID: <20260824153517.681d18ad@gandalf.local.home>
In-Reply-To: <f70d634ff65d6b1bd61c4ae517cf522881a23c61.camel@redhat.com>
References: <cover.1787243842.git.wen.yang@linux.dev>
	<dc58717cc225389b041dc36c684df23e3253c473.1787243842.git.wen.yang@linux.dev>
	<20260820165819.5CCC71F00A3A@smtp.kernel.org>
	<f70d634ff65d6b1bd61c4ae517cf522881a23c61.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6F85220027
X-Stat-Signature: sidyxqktwjz7gmijep6b1o86666angpp
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SWhFcumRDKAhJkSSTc38YgN77SZ4zlc0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=VjLCKRA9bS5fzdj+RNBSKmdF5cEac6ICyUrSd8agY7g=; b=hq7xNGb11D7XLPuornVY7VnR3wwClzogFnGY4vyTCg/ft+kKh1YoEEAwVW80iCcfRagM/CUmBG7EPAMEWU94OcYPLDbckJfkSdbhQWk3h0AgDcCZuU9WZDd/kwhccb6exCqJrJOf/nghbYcnvEbXQBARXUut3NFWs/J5QgYrbfE=
X-HE-Tag: 1787600076-19111
X-HE-Meta: U2FsdGVkX18U/eSe6F5nFLg6usAq0I+PniBaVc3yTEatbRoi5FLiAGSch/cUymCVWXowU5N81m1vRzUglmPsbQordEDpD7b0sYTUfzq6vp0Zsw2mtne2NSCI9RlD2F5dxm6uloI1/p4W5LsCLl5oKqrSnECp/AuN3qNjAwLf01OKFwEhaTLyHW1qmEO1f0JRx12l5nyvD/QAO7O5OWMLmf/6gk5c9KnGQ6WuxjamNg5z523KwCsAujwo+m3/9s5c+JYvBkUdRR+5/wBFby2AA1xwJT7eLQ+LIG8EkRo1QIRKIiylVkPm0eLIldprGWkIgUoeEihVg4hgiMtSvNIpBtT0Dm+EmmIA

On Mon, 24 Aug 2026 12:08:25 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> In my opinion all this stat/dirperms thing is rarely useful, you could just
> write the concern in a *brief* comment, saying we trust 4-5 level ups are still
> in the repo and we trust the repo, just to make AIs happy.
> 
> What do you think?

I personally think we can ignore this comment from Sashiko. The only ones
that should be running this code is those that are running it on a test
box/VM. That is, there should be nobody else on the box, and the system can
be blown away at any time and nobody should care.

-- Steve
