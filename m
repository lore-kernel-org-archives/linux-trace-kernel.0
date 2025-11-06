Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5233A01E;
	Thu,  6 Nov 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449114; cv=none; b=qMr7TcprMFVI/LF9JKyuW4U+WgFGtjZDGfnvR+ng0bQIKeZMNwLg4n7P97hopy3fObmSicUL2A0hB7ckn//leLucqGBsV3Uf8oaPC1Jk58fv7Nl/dTUbvxWgKFv+tdFXQ3DGX+Ms56mnarf6FSD73yzaGgYDaPhBWj9ehOFXr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449114; c=relaxed/simple;
	bh=xIVqNeX2vQl98nDZX5EYVxD9pnztau4qp782rYVbNtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmEyxbPELh5hD6r+n3Mkwa7v05zk8gy+iwmbgcnWpmTs73U02Y/HHXJtZ0Vj/PwuBmTtSrkipZZYXK9PcDod4Ar94lEu08+/qx1yc1mgWQVnXHi23ozHAtE6jDxkPqhRunxEIOVIrq2OdedKuLLdS8Fibdv6WShT+Yh/N1W6Bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EBE89C01EB;
	Thu,  6 Nov 2025 17:11:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 38AEC2002A;
	Thu,  6 Nov 2025 17:11:49 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:11:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing: Hide __NR_utimensat and _NR_mq_timedsend when
 not defined
Message-ID: <20251106121148.20d14b47@gandalf.local.home>
In-Reply-To: <20251107020104.fd7f43772d3b0ce5b28474bd@kernel.org>
References: <20251104205310.00a1db9a@batman.local.home>
	<20251107020104.fd7f43772d3b0ce5b28474bd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 38AEC2002A
X-Stat-Signature: tc3dfsinbeej7xia6t4co15p1naaqhkk
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Y4Y/6tu+DGQCEsDJC1TYzwtpYv6c9FZs=
X-HE-Tag: 1762449109-524249
X-HE-Meta: U2FsdGVkX18yUNTfi/XCuHrwoNB8TpxA1IiQdoGKKgdzAChU4cDd81UqIgT22DEGvrf00b+XNFp571FAhQ0tqKTZMKfBfkF/mnoF4ZqD9hgb71cxoIh9maQwJCrFoOisbiK4WZFZEWKT4CM6SKgkc/7xiB7tXU3fYVMY02fCCHcUui06Mierywqc3XnCzt113S2hGGOuZwMN1i2ZUc7KoAskZDPgxM7E4/Z3YCJB3SwESk0vr7CiCrH6NXv/1yraK3eFo57Tiedmk+COIVlse5Ymt1kQoMNcVmdUYSuAEl/i1BBtHuN0pJy7nZP70ADJr7tCboMaIaIa2einbyvRUiUDGq7ItZh5DXahxSoAVM+PElVZw6BZWfep5fQ2ZZqmGUenekTa4QUKfHFSw48gyg==

On Fri, 7 Nov 2025 02:01:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 4 Nov 2025 20:53:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Some architectures (riscv-32) do not define __NR_utimensat and
> > _NR_mq_timedsend, and fails to build when they are used.
> > 
> > Hide them in "ifdef"s.  
> 
> (I wonder we can expect that other __NR_* also defined on every
> architecture?)
> Anyway, this looks good to me.

I built every arch when I did the first update. It just happened that my
scripts to build riscv-32 was actually building riscv-64 :-p

So it's now all tested.

> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks!

-- Steve
