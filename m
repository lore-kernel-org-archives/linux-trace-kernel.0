Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AE35955;
	Fri, 24 Jan 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731178; cv=none; b=SrFKDuZzu4c01t2j0f9jsF+UyZq9sqes0HNQTt/bXXa/6vbNQFtoZ5vywE9AZUx8VQN0nuyiDfzVoqcMESWyJBRH0IWieSPfPqDxn7tDi3rWLKV1+hTI/AYMURJQu7miUzVN7LGiAnYycT/vyUyLPdShYPpPxwv7i+7fBWubF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731178; c=relaxed/simple;
	bh=9xFOhRlaexaIYYD20cZv4JkiblqeEQT12Xny8muagMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMPkxYyh8k51Ni0xGe/e7cnCk+hJ15UxkHf1C/rxHg5zviee76zGwTjLL8M299TXDxvtVRM1k3Yl1vmcFQqO9VuFSqGQr1+1KRT4GJouVu6JSb8v6MF0SB/miHpWsijBw8pqz2g9jXcZOhGs6KKr+L237w0O4UPHiNVEZ/CtEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4B4C4CED2;
	Fri, 24 Jan 2025 15:06:17 +0000 (UTC)
Date: Fri, 24 Jan 2025 10:06:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix the wrong format specifier
Message-ID: <20250124100627.7e7af0bf@gandalf.local.home>
In-Reply-To: <20241119102549.5da4d2c1cdbb7514014cd273@kernel.org>
References: <20241105011048.201629-1-luoyifan@cmss.chinamobile.com>
	<20241119102549.5da4d2c1cdbb7514014cd273@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 10:25:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Luo,
> 
> On Tue,  5 Nov 2024 09:10:48 +0800
> Luo Yifan <luoyifan@cmss.chinamobile.com> wrote:
> 
> > Use '%u' instead of '%d' for unsigned int.  
> 
> Good catch, thanks for the fix!
> Let me pick.

Hi Masami,

This is still in patchwork and I don't see it applied to Linus's tree. Did
you forget about it?

-- Steve
