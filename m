Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7D2F1FD0;
	Fri, 27 Jun 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033770; cv=none; b=NwrmXUgJNWxxLzlJFLTrDtmr6EGohfhQc/lv0T35hdFbWj9kaDyofMBnL3AU7JUUJbsjKLfRaF5WSDTWoa22un/TWHUmOcWpsZX13HZWuIn09jPSNld7ctKIBeYOIfu7nnCUrtBKN1e1RYLwZzRRVDDVfqONBs2VLml6E6xQKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033770; c=relaxed/simple;
	bh=k2FLc+0Tz7FO8s4O76P4qaCM9wzLqwJ0DDO4zygQc44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Onu43qulf7VjwNRLSX26GQUgfOClue/o53xGeivL+GstDp8jglE4JfCCJpznHypGwPInGtstpsVVXTsICEExAwekK67x8Rch6E86aJ+gtaa+6XGEJLyX+8pCWJfm5F+jwzIUKtMkAoVHCSV3waqxar3Pw7Xlmjh9u2/gsDw4iJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 489E3120FC1;
	Fri, 27 Jun 2025 14:16:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 8AB4C6000C;
	Fri, 27 Jun 2025 14:16:03 +0000 (UTC)
Date: Fri, 27 Jun 2025 10:16:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 00/19] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250627101631.59bd7ab0@gandalf.local.home>
In-Reply-To: <20250627124248.fpuBrdWJ@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<20250627124248.fpuBrdWJ@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ue6gif9a3x7tjq6nmyxm5qncfdq9zpjg
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8AB4C6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19IhCPc7moF5EPHorqK1dcppX4vQe0dQnU=
X-HE-Tag: 1751033763-947743
X-HE-Meta: U2FsdGVkX1/8zHZi0UX/yXGYn9lWTvuruY0Mtcv1fXD3s+dTRTyPaycyvzQK0X+Jx3jWaGpXJLjnwjLEeH9mCmv9sZHPX927/0EQiT7hGMXuTj2V1OdjudYyR8xZ5z/MXFj6xZM355cKUASjYAUjaaFTGqvv15w2BtSrLiK9TJGAe7wu+JiWCnW8czLxaSQuz3CuKvsKlbXWndrtVHEujN2w38WDZLmdrBTv0ueFqY+HdCylg7/llmgsyftaKFJHX0wh0KMpL6fAYcgGd3trNJ5bx947gObZwCoNBXbXnpglJplb9iGLj8mIohULNChQRnJPMWX69Ydur99adod8Ex641KDM9JKZ2BwrpHI72vE=

On Fri, 27 Jun 2025 14:42:48 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Is there any chance this series could be applied soon? I have some more
> patches which depend on this series, so it is holding up the show. I think
> Gabriele needs this applied for his patches as well.

I'll try to take a look at these today.

Thanks,

-- Steve
