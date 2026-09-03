Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A627175A83;
	Thu,  3 Sep 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479293; cv=none; b=FY+jDEF6KPqleZ+v3q+83EAQQa0BT19frIFadLaqUBCMhdsMIgR0ntEFX9Ml9kzcI6uCTlwTFS5EClDuUMO0eP+Z6+bOmEmHuOAXXGlMEvQCZ4BzmtkvsKXG6raoWVTSKNPefPH6GoTvanphYFFjZ/+BJGaB8nO9r6IeNXdkgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479293; c=relaxed/simple;
	bh=uDyIC562piYe9r7MsUb/NK3RSqjK4yUS3iIG8rZDMa0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tY3Z+K71MM4cCa4vM1R09RAKXe6KlhNT5w/jIiQk3VMjRZOxc8hxqzvqE4pQe1LauD4tlIdB2osZe809tQnSJjkQkHEUtj0k0yX48ASPRgi/BBS/nWf9aWNk3+xvNrm4uNIwdUVyj9MB/CBKdD/Vytut+uMxwJBswOR4OApJWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuaFyiG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuaFyiG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78391F000E9;
	Thu,  3 Sep 2026 23:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479292;
	bh=B8ppRYGYJRXQbu+mdFJKoK8l5i9vMXfeuc2qB46b5Xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MuaFyiG+SxZaFfujcPp1BT/M9pwFxAgVRn7Pq+tm1CgOCPt5Idv9FBuNVAhE0PEXC
	 MmBc2WLTdoJw0blpQTH3HiW2FzGMXxuk09aEPCYeVavHSrMQLBMTIGfZlLC2wH+X57
	 4w4iJxneLHc0IU8IH1h2Et3Dhwnn31lIttkNb4oSp7fl2PnAVn2+e3NRjxwE2Ye/4j
	 aS8HyXRpPrOUWrgOmz7R8HWwieRe86Ue5k1zOs4PXqehDO4DErIbXUPLdvboNICQPB
	 Riuxx4QLw2zNdHwTJXZc4huhnLc2qXhgspQqa63E2VM8tTO5aEY9EMG+wUQESMm+nB
	 xByFNoNwA6E3A==
Date: Fri, 4 Sep 2026 08:48:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peng Donglin <dolinux.peng@gmail.com>, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
Message-Id: <20260904084808.12a9c7a1c4bb8353d753e026@kernel.org>
In-Reply-To: <20260903123606.6e5bc37e@gandalf.local.home>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
	<20260901135715.4812fde9@gandalf.local.home>
	<f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
	<20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
	<20260903123606.6e5bc37e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 12:36:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2 Sep 2026 23:55:33 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hmm, shouldn't both the actually applied size and the true size be displayed?
> > e.g.
> > 
> > ret=0x5 (in 8 bytes, true size: 16 bytes)
> 
> I have to ask. Why do we care? Is there a use for this information?

If the structure itself is being returned, representing it as a scalar
value could lead to misunderstandings. Since we can check it is a
scalar or not, it should be noticed. In this meaning, I think "(trunc)"
is also good to me. (at least user can notice it)

Thanks,

> 
> If not, ret=0x5 would be sufficient.
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
