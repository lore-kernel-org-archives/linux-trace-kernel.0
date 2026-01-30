Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE78352FA7;
	Fri, 30 Jan 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792245; cv=none; b=hovQQ3k2dEb2oO8tklAl7Ca88t/QaohSreZ6l27J6ZaC2TDeu8mWU1IFQSM6h+IJRf1cSHsMUsP03n44evrOP2O6iXhICJCks03f9UgoopprlkWjzpHwFdK869LMDePh7qae7YbKyK6L5Yj0Gn0BqKZ054hTNBp7HrABRDoA23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792245; c=relaxed/simple;
	bh=CSsp9mbpvRDBnN2ygcdH090F8cQhfMR20JcrEPVYXCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+2o3GmUPZ8Ffq80OkNYt1V/Lp3zUHTQIe6o5YMnchBUrW0ywMmpqgWfwtAZeZZgBoqMUOdY/EOkHrMl7CnvnwxfWcP0vM06GyjmX+Npq2TNl1RwTieZTvWYwLrHwXRA2d6idYDpS9Qxv21rmO6UZH9AALvdL0gCYwWriy+YBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 10A44B7F2A;
	Fri, 30 Jan 2026 16:57:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 910D332;
	Fri, 30 Jan 2026 16:57:19 +0000 (UTC)
Date: Fri, 30 Jan 2026 11:57:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, ptesarik@suse.com,
 m.szyprowski@samsung.com, jgg@ziepe.ca, leon@kernel.org, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] tracing/dma: Cap dma_map_sg tracepoint arrays to
 prevent buffer overflow
Message-ID: <20260130115735.432be761@gandalf.local.home>
In-Reply-To: <d6c7d83c-687b-4844-b515-9f7342278628@linux.dev>
References: <20260130155215.69737-1-kartikey406@gmail.com>
	<d6c7d83c-687b-4844-b515-9f7342278628@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nigqwr8kxn4us7rsbrfxbusagir7n87z
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 910D332
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19k77RyRRcCcJ+/GkgQXvbTFc87XZKHSnY=
X-HE-Tag: 1769792239-503376
X-HE-Meta: U2FsdGVkX18HpABSnjy//cmSO20CTZhUnF2As0novxuoT64Rn2wxlGX3j4gu3ULydsQxm7mK85uy9hYI79J/lIKaXIxPQjaQLehkWDx3+QihOCIqKMXdEsGUhrvE52larwssvMq2yRBbdGenespGBJMpkQIgCzZh7QZayRq9DWsmOZ78oV21Y/o6OFpHJpsOzvgGdrPzIXY/LTfqFwHWOiNe+Di6/9zmJG9+JxE0oOrv8KNVtuXmvaANmxztFpkjPompez1LTr1/WizuSrAvZJ9Ce6xYqaiDe+gM+uZXVoytEuZHFA+45qjvJ3PHKvMy3QW9Uz3La+jGcWu0fOJh+FuzQ3wDWFWY

On Fri, 30 Jan 2026 11:27:47 -0500
Sean Anderson <sean.anderson@linux.dev> wrote:

> Reviwed-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Although it's a bit unusual that there's no limit on dynamic arrays like there is for %*ph.

Dynamic arrays are done in fast paths. I rather not add an extra branch to
test cases where its most likely not going to exceed the limit.

-- Steve
