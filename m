Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A81AA1F4;
	Sat,  2 May 2026 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777749797; cv=none; b=HXOmn2jxvkVPyK7fFwS1RVW5SMriT8/fNHe3wZdREbXn1Y3vQZWJz+4kUjyAsEvKe+saCiY0rqceDxstlAULl5wU+6ZFd1zyAdlLpxeN/t2jY+kO+EVi1ineg5/cDn8ZAu7kw28U5qM/QlgdKI00mIyjCY3jQoyGTz5HHc171jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777749797; c=relaxed/simple;
	bh=vDi4xGv0q98PNW1jXr84JP3EVfHUo37AUzpjy5K55K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8uLtTxMEObEV3ROD6/ASXlabRRmx7l/zXmKzIn4Lb7efmdN08gen5ZBH/7iIu9V75SYSKpfjba9xZBDBtqgD6hRztIEsqEhZj9h2YkxG/8lHNbROA4pVSq3TNgW7TER+q4z3vt2k5X8jpW3UrH9awEjn9uSoItM4q+Sl60+8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 410F6160524;
	Sat,  2 May 2026 19:23:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 3A49C20018;
	Sat,  2 May 2026 19:23:06 +0000 (UTC)
Date: Sat, 2 May 2026 15:23:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19 0/7] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260502152304.560a5954@robin>
In-Reply-To: <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
References: <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/bduRHcIgi7cE_At8/bu1uhd"
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3A49C20018
X-Stat-Signature: 1p61ghnqdpke4wkizqjbgexfjuxxyhqw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GhuIyQaIfEX0jv4huB7H5ggusR9h7p+8=
X-HE-Tag: 1777749786-296731
X-HE-Meta: U2FsdGVkX19bUoGqhA2+ZC9WRj15X+DlVnMrZ9GL9LDsFXFqNWKrSedMwv9eDtwKQQY5jzSCeRN5ay+A/mpFH1V41iSgOsKuZmcRpJY7Q1nBf/36tTBCukt6pNL65VMzdFrjl5+rymlfb5aO289feVNy9DTZJ67ZHW7cyV5mcnZUkB8CGKYEXgb4hde5Qawtehde5AszOb8wuQLwbGCMLfEVkRz74Wn62mZ12x2rGFS0UvXqyy5Zk0iK1Ez6ahmDW53ok34uWPRJoAEBXdp453CMHj5SCFdAoBolaQjzHI34ctuqC21bOD+f53dLNIWwkhGeeY1KjGU=

--MP_/bduRHcIgi7cE_At8/bu1uhd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Masami,

I applied your patches and enabled your ptracingtest code. I noticed
that when there's dropped pages, the trace output is not in order:

 # trace-cmd start -B ptracingtest -e all -v -e '*lock*'
 # taskset -c 5 echo c > /proc/sysrq-trigger

On reboot, I ran:

 # trace-cmd show -B ptracingtest > /tmp/trace.out

Then executed the attached perl program:

  # ./read-ts.pl < /tmp/trace.out

And it errors our:

 30.212495 < 30.213534
           <...>-1048    [005] d....    30.212495: irq_enable: caller=irqentry_exit+0xf5/0x710 parent=0x0

That is, I think the zero timestamps may be messing with the order.

-- Steve

--MP_/bduRHcIgi7cE_At8/bu1uhd
Content-Type: application/x-perl
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=read-ts.pl

IyEvdXNyL2Jpbi9wZXJsIC13CgpteSAkbGFzdCA9IDAuMDsKd2hpbGUgKDw+KSB7CiAgICAgICAg
aWYgKC9eXHMqXFMrXHMrXFMrXHMrXFMrXHMrKFswLTkuXSspOi8pIHsKICAgICAgICAgICAgICAg
IGlmICgkMSA8ICRsYXN0KSB7CiAgICAgICAgICAgICAgICAgICAgICAgIHByaW50ICIkMSA8ICRs
YXN0XG4iOwogICAgICAgICAgICAgICAgICAgICAgICBwcmludDsKICAgICAgICAgICAgICAgICAg
ICAgICAgZXhpdCAwOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgJGxhc3QgPSAk
MTsKICAgICAgICB9Cn0K

--MP_/bduRHcIgi7cE_At8/bu1uhd--
