Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7923B63F;
	Wed,  9 Jul 2025 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088886; cv=none; b=Ay/oKh1WeDxH8++skYcgCJDvsxKWbqM5SqyDzKm+lU1RlFpgoiBf8ga/XZlYeQUDoRYNTvh+T7/rWVtgueO8uFmX6v/ZTZQs2Y+4R/9mbR2OakgaQ+25HuoguKhxkZoDHeMMb3m38k7v6zwIYI9fTUblidcFdBrjydjyRcKXAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088886; c=relaxed/simple;
	bh=xM0NhVFSnSFAt4wKgJU33uAkmJMv4mZyLqSI04pTubk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT+N65mVQtmxz8EhcvsnH0el4MLr123M9ce0QmE6aGjSKB3L9AijtcMZYwNyDbTYDaqzWLLkA0KDdt57/jq1wWFaKyytV94GoWxeR6znwOezrnsoo20N/hXVvjaeeu7+vW/ZNAkePDcFxtZGIIfdC/Hg18FUcW7u5wEMz0a8WqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id BFCDA10B82C;
	Wed,  9 Jul 2025 19:21:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id A040720025;
	Wed,  9 Jul 2025 19:21:20 +0000 (UTC)
Date: Wed, 9 Jul 2025 15:21:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 02/12] printk: Make vprintk_deferred() public
Message-ID: <20250709152119.102e9eaf@batman.local.home>
In-Reply-To: <20250709190938.8KErh6st@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
	<25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
	<20250709144914.6ee7199b@batman.local.home>
	<20250709185334.uFpAU2mC@linutronix.de>
	<20250709150452.6646c168@batman.local.home>
	<20250709190938.8KErh6st@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x8tw4y8swpxcsy1y4uyzg4hk61oxkngf
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A040720025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LsMu/63p2cvnqD3CjOJcHTAU9t68i+oM=
X-HE-Tag: 1752088880-532486
X-HE-Meta: U2FsdGVkX18zZ1ZtQLY/SfMk8q//+LPvqSmj0ZS5pceD5B9/OimfFWyaeGNYC2OuAaAPfes2B38T7sas0ghzjbKpQFGVCrDA4xmJQ+8HLizBXc5pN3ye+rInN3C6Lb1V5+K375gsrNMPUKj3W16QjDILQjZL+vOmrp1X+U5Ju1B/IJjZ1/FLDrfwksQFY13G3w3oYbCraLnzpO6PbtQoJbspl+8Cz/9JlYSjm4u5KAZ0zIelRKXpyb0wyo6vVwH3iIUyuTJd9hpYI0HSSOiFNbuchtFOmDCEJ3HJCy1JLYhv7+a4UTNYs1lceXyfbX7O

On Wed, 9 Jul 2025 21:09:38 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Fine for me either way. I worked with other maintainers who prefer the
> other way, so I had to ask.

I used to be one of those maintainers, but now that I'm relying on
patchwork so much, I found that full series does make the workflow
easier.

BTW, I also pull the series directly from patchwork, not the mailing
list or email.

-- Steve
