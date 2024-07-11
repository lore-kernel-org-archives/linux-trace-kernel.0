Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A815ECE1;
	Thu, 11 Jul 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706928; cv=none; b=uw1ItUOWelytO13n+y3nQWimDEnsN2nBYD27rHS0Ji8pKDoEGHoQsuMw4VxnZdVlJ1aQ9K6IEStZSZbaPuoputvCDRdmQwv4sdsMVyfRUNZ6tJ+6nh3ISjnE0wY6Cf6kkI0aAljf2VL16CF7EjXn/ia1PCAkTgu+c5bYFToKVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706928; c=relaxed/simple;
	bh=i2KXEHfvbFc1r+W2X8rR0szA2hrH6twiaye+JxNg5o8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oST6G0YvP7gpyvq0iKoXQHATbY0XSfSKOryR2Odtv/lSDGXdVI0bsx/jyuZh5SyriBuGHAb61+T7J1+XpfKNeCqRCHXB3AKoeRyjnnjpUARUpy588VnU9HdNvVcUm45BbRhDAkBZWcsAHKvUH7czjqnwoV+s7NyfFRx+jrTZ1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8439BC116B1;
	Thu, 11 Jul 2024 14:08:47 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:10:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
Message-ID: <20240711101009.5ebcc6ec@gandalf.local.home>
In-Reply-To: <07b88f71-5b77-4c16-bd55-3f5e3812c93e@suse.com>
References: <20240703075314.23511-1-petr.pavlu@suse.com>
	<20240703174410.099e8784@rorschach.local.home>
	<07b88f71-5b77-4c16-bd55-3f5e3812c93e@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 13:03:47 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> > I'm dumb. What's an "era"?  
> 
> I meant it as a calendar era or epoch. The idea was to hint this is
> a number that identifies some structural state of the pages list. Maybe
> pages_gen ("generation") or another name would be better?

Ah, out of context I thought it was short for something. Perhaps just use
"cnt" with a comment, as that can be generic enough for what it is.

Thanks,

-- Steve
