Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4717485;
	Tue, 28 Jan 2025 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040342; cv=none; b=A7YILBlrT9MzMjckSFCaWthYtwe82dhwC5kSmFkKzDKWSpS4Zhz682UleN4rB4Bbky5MjOxIYX2JF+q79XHzVGrtazAuOvWtgd9tiXlEOMoO2PvZUWm7J7vPVSe7ahcD9Ui+J1Sx6oK7241UK0zX6Ix/WeWxX7vAFgocUIMRhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040342; c=relaxed/simple;
	bh=guUq7NITdaaKVUkTkKaJyOCjpJOBNT79z/pzC0qm5rQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=teNiWRCvrt0EgIX6c7MDdX6RjNpkbJno0f3pJv0StQ25wXL965ffP2uyx0ZfjcvL9NGV+DUlBg2fLlkt07rAgHoYTVKUaLDy3MaD5F6sV8sWG/0FwcYHWfHDGIF9TPKOmUwsdrIgMWb/bmfQSaKgGtQi5j3kNd5lFCB5NFkRfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHTCJqpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHTCJqpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D0DC4CED3;
	Tue, 28 Jan 2025 04:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738040341;
	bh=guUq7NITdaaKVUkTkKaJyOCjpJOBNT79z/pzC0qm5rQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHTCJqpZl3y2QXAt7MjdHW1WuofMO6rojpuiald2YflPZTZ74OMjzS+vFLoEmWINf
	 cfuAvyf9voEbntz2LH9XqwC6S1RCQhkSoZe5sl/SBhEgaXvinOxUHPbv7dG01yCrwB
	 0qik44kq9WvY9adCMUQEqT/bBHmxqYRbqsuhUx7gFKTHi3+3wUKfek/zBaWyBOIM4e
	 hV6EN2+Aa+aIrHMQCzngKwBY6YoO28s8c1ia3QjplG3vOERj34yoLjphUicnrR/b6v
	 mCmb0GfR0drMwGx1UMLgQCpSBcYx6IGqTYWHQ7ke4Ik/1TRMED8OLkCrKKhY/OQsFi
	 aMvS7VFg0dBgQ==
Date: Tue, 28 Jan 2025 13:58:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix the wrong format specifier
Message-Id: <20250128135859.ec38bcddb62f2da2c8065ee1@kernel.org>
In-Reply-To: <20250124100627.7e7af0bf@gandalf.local.home>
References: <20241105011048.201629-1-luoyifan@cmss.chinamobile.com>
	<20241119102549.5da4d2c1cdbb7514014cd273@kernel.org>
	<20250124100627.7e7af0bf@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 10:06:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 19 Nov 2024 10:25:49 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Luo,
> > 
> > On Tue,  5 Nov 2024 09:10:48 +0800
> > Luo Yifan <luoyifan@cmss.chinamobile.com> wrote:
> > 
> > > Use '%u' instead of '%d' for unsigned int.  
> > 
> > Good catch, thanks for the fix!
> > Let me pick.
> 
> Hi Masami,
> 
> This is still in patchwork and I don't see it applied to Linus's tree. Did
> you forget about it?

Oops, thanks for ping me.

Let me make a PR.

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
