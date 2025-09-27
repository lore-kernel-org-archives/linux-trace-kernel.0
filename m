Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BC2D8791
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758967806; cv=none; b=nEwBgRMKvoF7j1suyYWgB4XzzVjcAZqwWTsL0DJCA8cT/KwtqyHd5FwWDA1DaCbx5HSAbBmm41D4kcQZoajZ5N9NXGgpyCTVPBIG4/nMFU3M3X5iH4l0NCah/MV6EUH2CK4PIIaLYSyH933HK6D3gFEjoaiXvpMP8syr9WHqqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758967806; c=relaxed/simple;
	bh=qAdhUfnZ/jiMqb3IdJhzEatRlvzazXfUyK5ae3jGYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyB8UqgJ5wHTzqoTtU4a16H6YFSDaZN/WpUwvM5c0TKT0SvQC74hVGF8oyc8BObzRm10is00RT/YaIZ5Z1txLVbtTZst2lBCunnOKCYirCbYGfsQSKzATPTYx0hjslRxxB2d8Rc57vmvEN+a3Z5YOSx13URx/IeMpNfvn2N8TZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 079161DFA91;
	Sat, 27 Sep 2025 10:09:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id BFC052D;
	Sat, 27 Sep 2025 10:09:52 +0000 (UTC)
Date: Sat, 27 Sep 2025 06:09:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, linux-trace-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v2 0/7] tools/rtla: Code consolidation and osnoise
 actions
Message-ID: <20250927060949.45f53940@batman.local.home>
In-Reply-To: <20250927054741.10e22942@batman.local.home>
References: <20250907022325.243930-1-crwood@redhat.com>
	<CAP4=nvQR3YDNVhka9QCNQVB=QEytxLPdFrx_nNJbNm7-r9ujDg@mail.gmail.com>
	<20250927044454.0525d39c@batman.local.home>
	<20250927054741.10e22942@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8smihz7x15mqryb4xpfzwupqsoqwmqmm
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: BFC052D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qbntRCGfJgmmfjmZBLiYe8nAzZoiLwNg=
X-HE-Tag: 1758967792-794367
X-HE-Meta: U2FsdGVkX18At+FMienZ6i3KuZeUqWJbG0m1tX1BMdG0bkkeovWtxbZEylqmQUfoUuQfWqe/42LcJ7EA4MUIdKN61NnGMyXIlGMm2xHT0u100P28XRplEJSnD6UB8NI32RHBfKijPUrSiWmHza+miM4jHOJz70KSYpDxHePEV0v3qJ4lNipLYrxNoJaTIn16YlK5QWZBSuYMWtDexeEsDifYyHoMwDznEYpsj/7a7aIpFEDqKkgHNZLXFwZIWrL6ganbGw2ErPMHHS5WSUU3ncs34TH4PeGopHpU53jY23w6xmzrDYOSl4J9CD/TU41sGXSBIP0eUEPaLIntIe7Qr+u5XSFgEYO3TUS60yqkeHAaqnqr6q6yTAww7wPIE0yC

On Sat, 27 Sep 2025 05:47:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I applied the patches and then ran "make check" and triggered this:
> 
> tests/osnoise.t ... 13/17 
> not ok 13 - top stop at failed action
> # Output match failed: "^abc"
> # Output non-match failed: "defgh"

Hmm, after applying the two fixes this appears to go away.

-- Steve
