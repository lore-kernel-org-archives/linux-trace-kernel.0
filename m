Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8335949;
	Tue, 31 Mar 2026 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960435; cv=none; b=QP1DuK/tRGO4vffyxwVL3ob/G6oSPBbBRaecVvozhrsAEhe0Eqe5uJJo/Y74HbRXJsgo39VrdUEr8smdJzFDE+YnF0ti4GNtr02xZ03vaaKXjrWhPfymrz4ErTbV0N2zPkIhzg7OGP739axhEyr7pwLmHI8kRj/igCoQaBuuDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960435; c=relaxed/simple;
	bh=iD9u/TDFLZXaBIfb9d4CrtcHif8WcMyziXkE6pNnxmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl9qwYUbbEWnB3EEEyXLcdTF/tPTVKGFbSSLoP7rFmmixDVBwb0rHbp6HpRFpU3VeuZreAciyME9j56y9ZXZE1JLylSmmyDuwxVxlTOkmmyfOLPeN85mFQOBHOmpwXKVhibMRx1TbziuK0JoRuBK+QoX6fZP2ht/XVQKicZYNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0F6FBB593F;
	Tue, 31 Mar 2026 12:33:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id D631620010;
	Tue, 31 Mar 2026 12:33:49 +0000 (UTC)
Date: Tue, 31 Mar 2026 08:34:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "kernel test robot" <lkp@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "Linux trace kernel"
 <linux-trace-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Move snapshot code out of trace.c and into
 trace_snapshot.c
Message-ID: <20260331083447.2fbd1b18@gandalf.local.home>
In-Reply-To: <6efebcb6-194e-4c21-8808-fdf09160eac0@app.fastmail.com>
References: <20260305211810.3f48aa07@robin>
	<202603070230.Zz4BBLtb-lkp@intel.com>
	<8580f943-4c37-4c66-937d-adee13b72201@app.fastmail.com>
	<20260330120516.73aede9b@gandalf.local.home>
	<6efebcb6-194e-4c21-8808-fdf09160eac0@app.fastmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D631620010
X-Rspamd-Server: rspamout06
X-Stat-Signature: jjxp7147jetaxyprmwswfuc4usb7tep5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+VgUzgIpfo7HME5G7oicg6oq0HTlHbOkc=
X-HE-Tag: 1774960429-220878
X-HE-Meta: U2FsdGVkX18CvByNU7WXef5oHwMDexXeg20+yKHo0Evg1zPHsTZjeg6BH/OOEqF8P1NFDCq8NTZehgUA32UzREYCa2KjPTs1PX+a2GuV5IoIBbAJqIKX3bb7UuUtBLqSGnwABd8MDhBwB13xWRx9ox2jERRjaNNXqzzaRDwiCdXfBKekN/77GARY8GEXwD+uTjNJnGcjMMeR4dN88mVIC/kbbsjUIPI5wZ5fIPQ7IuKm+GvBCsGZxnVp7codzcw6HR+gvrL2ZxbH7IyOotfOVFkmdX0ZCpzIugoNr/R4k/LhhZwkxyJs6gS/OoretcQqGa4GNSTewB8f41SdFrIQuiPk6JTNfstR

On Tue, 31 Mar 2026 12:53:38 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> Right, I assumed it had to be something like that, just didn't immediately
> see what. I've sent a patch to just remove the duplicate inline
> function now.

Ah, I had already sent a patch to fix the duplicate because I saw the
kernel test robot's report.

  https://lore.kernel.org/all/20260330205859.24c0aae3@gandalf.local.home/

-- Steve
