Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AC4BC014;
	Thu,  2 Jul 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000843; cv=none; b=epaW0ADo0X0qED7awiD5eeMNTuo1h+Hn4yHTbdmvnKRMd3LBZ4VCx6511rt75zevR8sPycAVAJV9VG1WFiuG/jAYMs/QQgg4kWqZpr7pubwrVd/s41FSdhN5hNEFHzWW+tx+aOwrCigt61Ty9dP5XWV6ex+lSWksdA0izUXjXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000843; c=relaxed/simple;
	bh=V9S4G2AT6S20sfZBXUptijols8v362/f50WgdVj9JfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GiWAU+Ap6RPYReZ50Jqo+JYtlTdWogKPShwZI3vJHSvw2zpwl38+Yd3hcabpxbfJA1yfr/5xEyvAv51x0rJWU/fC2kPHAkhLvkuNrRHbbZS131LpGil/EPvDRQwi6AsWZ+DRKl+E19uw/UKc4/DuVTQHC6O30EBf6EhoEClZ9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7LCLef5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iI9u50vi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7LCLef5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iI9u50vi"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783000840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9S4G2AT6S20sfZBXUptijols8v362/f50WgdVj9JfI=;
	b=z7LCLef54NnJMy8kvXLapZ1XC23ktpSK4xf6gSa0ocNP0Pa5q5UYlZXtVzqwB2x1VlS5M9
	W6OdLLk+2NWarEh1CHHyDCsXjgJOk2Ip23np7SSqLoVEbjulH6tadm2ioMyBPzcbVLIfO1
	NArMD0TkkBIJ3P7jaducsJrACNW6DLkwa7uDkr1uXnsFFEz0rZ3ghXZEY8CLMbV5wTroub
	KctWko5Q4EZ0eTS2Kl3MHM4x0ND6YxEN2JZ8llkSG5AV/fAulR8rKGTwVE9V6TmlE4Arvy
	WJHxKPAyIauhJ6FZaNyUQYNDQ3vwz48lut04UKRg7JQ1wifFpb1TrksxqEjzIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783000840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9S4G2AT6S20sfZBXUptijols8v362/f50WgdVj9JfI=;
	b=iI9u50viC7vFiL2KSGrxn6GsScgsxtqMarQ/bhhp6h5/w2pC1I3viFrfjgZ8RktlL/Pwxq
	5WLGnszaIRF/pwBQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 08/17] rv: Export task monitor slot and react symbols
In-Reply-To: <20260625121440.116317-9-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-9-gmonaco@redhat.com>
Date: Thu, 02 Jul 2026 16:00:39 +0200
Message-ID: <87se61ij94.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Export rv_get_task_monitor_slot, rv_put_task_monitor_slot, and rv_react
> to GPL modules so they can be accessed by KUnit and future monitors
> built as kernel modules.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
