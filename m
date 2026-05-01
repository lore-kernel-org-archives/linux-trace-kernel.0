Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42322DB798;
	Fri,  1 May 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648783; cv=none; b=BBe+Spz6PZoyt7Ojx1Oapv8yfgBn2/4OqSCY9ORqFo+ZUFGrbr8Fa3WT716/vRurkLzsSjiIGqOj7yvRV2zhS5yJry9MFosOwlUBoadhuSksexyw9j4Wf70iJFsqt6we8zqS4l2y6oK3Bdw6Xwi7r+WXJ9xz7p7OAb7NWfvwphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648783; c=relaxed/simple;
	bh=EIRPZfWiFhpZjr/dmyjOKgcr+eG0l33RGRqjnPxCuV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuNtdFkDYUq8yT/30Jmv5hIoY0C1EPDY1rO7Nz5AjjO0BQT4NBhNTMvStTPSaJwS0/58hP0v9fAEJdmF743CHqeIhnCb9JyRaJwDMC60l7YpAQ3l9GmRFNNUBSLaydI4aXqlSTZhxX+KHcRW7mSUSaDE7I8TUB80d93dowyIShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4357A40170;
	Fri,  1 May 2026 15:19:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 7232A20019;
	Fri,  1 May 2026 15:19:38 +0000 (UTC)
Date: Fri, 1 May 2026 11:19:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Qian-Yu Lin <tiffany019230@gmail.com>
Cc: mhiramat@kernel.org, david.laight.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <20260501111939.0536140a@gandalf.local.home>
In-Reply-To: <afS7UUAfzgiSzEHv@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
	<20260429134226.49e95e9d@robin>
	<afS7UUAfzgiSzEHv@nova>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 7232A20019
X-Stat-Signature: zit65w4rcnb1oz31r8etc3cpoamrbrng
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sTb72zjP0fIfw28GYhw0Ku3Of6cUH/No=
X-HE-Tag: 1777648778-319631
X-HE-Meta: U2FsdGVkX19OvOH8PYXcX3i9cphaKHzdCl3zd1nQowVZEZ4gaFb5g1TO/UIGVW6i+lY+vZbaBK895LV/7puehNBdNvNAwN93IDuGEkbMOrqtP76CmUCSKER5eEhAmvyLUHRMXq8FGqvAJ0fQ2IvDS77TgkrewpGTiRumWKvv23aF6XbUPm4qG5aecmRgz4nKQ21SEqam3HnNUps9MwXmtuqCn+D+QyLJyHUx8bwxR2/DdlaAuOSImN/YoL5KYqlYFvDthU073MAzCOaWkDFASsx1GNqj4qrr3A0Lx+rn/nC0NAuAw4qLsrDSn3J9sf8QdhWJbsoGoEkj16b3s/0+OK+WKML5hzeK

On Fri, 1 May 2026 22:40:17 +0800
Qian-Yu Lin <tiffany019230@gmail.com> wrote:

> I propose using a compound literal in v2, which eliminates the local
> variable entirely and requires no extra include:
> 
> #define trace_printk(fmt, ...)                          \
> do {                                                    \
>     if (sizeof((char[])                             \
>         {__stringify((__VA_ARGS__))}) > 3)      \
>         do_trace_printk(fmt, ##__VA_ARGS__);    \
>     else                                            \
>         trace_puts(fmt);                        \
> } while (0)
> 
> This fully eliminates the shadowing risk without any compile overhead.

Have you tested to make sure a string with no arguments still produces the
trace_puts() and one that has arguments calls do_trace_printk()?

I'm fine with that one if it still works.

-- Steve
