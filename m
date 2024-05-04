Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391829D02
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 May 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714829730; cv=none; b=Y92i2doYD28qweYZQHEENF0OLIjPv+xoQO37+mdoAQpxgHkbZOV654lW6ALYGmiaY/IPVNJ1zdH8iVxCpvdnQ6xicsoB2Na2F3ilQ5RZGF7+lOfpyJHTQCh7mbCBt8u3XKB3RUYwaG0s0lpznBJTvJovGaLNYm1YoG0FyXzOXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714829730; c=relaxed/simple;
	bh=dzXrcUILWMRxJBhxTEE79aogFipuuS/d3boqQUPSJ9Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gu1KWyw2p78vSguwZEVA1B5XKzHxd3BYJklc7w2MCLqstqy7G28OAeamwG/9VJzZwPXSpci0m0EYeXPxlUzubZ8Z3qP4yiphHhBmZ6dpLW/dGH21Sh2BOxyJ/963Ul0SUnwR7sSfp/VWwcL7Nh0xfByOfqPEH3pRJwI0WvIYfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=N+WzFtx9; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="N+WzFtx9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=xepO/DGu9q8MQi+5K3bMv0xxENghmKqAWqwV0p2Eeik=; b=N+WzFtx9X2ObrR4g
	l/sZ2MfHrCT94YJuYAXmWjbQlZbcoD35eDvHwZqjtS6Nxbx6qoOfhDQnB3PiWWz4ZmkVr4Snr+eqy
	EkBZ2eGwINDe1DA1nhjVnjYlbQ8ThvPRJggg5LMq3ZVL/pvMKBRf3pV49WhM4dK6JGm+v7+p8Q3Fp
	Hu9vcrqIuSCNvq9JNrk/XsF3odCd5JbarYiOqmqlhY/GQ2Ukr+1EJmg3wAcgQ/ddk6/BD+goNj+pF
	o3S5qopOX24Fb9KG8KGds0NghpB5J9/jSxfox4rj5Obn6XHiOUvrPZEvgyYpaJ8iI5VSs1rby8HB4
	XG0OfPf0W8w7tG6PaA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s3FXy-004hOe-26;
	Sat, 04 May 2024 13:35:26 +0000
Date: Sat, 4 May 2024 13:35:26 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: ftrace_direct_func_count ?
Message-ID: <ZjY5np4coyMk4ijJ@gallifrey>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 13:30:33 up 122 days, 16:20,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  I've just posted a patch 'ftrace: Remove unused list 'ftrace_direct_funcs''
that clears out some old code, but while at it I noticed the global
'ftrace_direct_func_count'.

As far as I can tell, it's never assigned (or initialised) but it is tested:

kernel/trace/fgraph.c:
#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
  /*
   * Skip graph tracing if the return location is served by direct trampoline,
   * since call sequence and return addresses are unpredictable anyway.
   * Ex: BPF trampoline may call original function and may skip frame
   * depending on type of BPF programs attached.
   */
  if (ftrace_direct_func_count &&
      ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
    return -EBUSY;
#endif

So I wasn't sure whether it was just safe to nuke that section
or whether it really needed fixing?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
