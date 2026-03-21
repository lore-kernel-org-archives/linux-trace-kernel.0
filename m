Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2C155C87;
	Sat, 21 Mar 2026 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059715; cv=none; b=YfuaUjRWmBtQQOTcZLAq6iJ+cBKEoVkhv2sfPE0rOfEYWSq12lKqcD2qt4JEKUC0sfi4RbBJHvZHUvzNMBc4lPgi5kDCn+f3fJAh8+M6GZbyVdj+6QGFcbryidEfIEU3HCGUpZJp+z4OWkvXQ8xYNvW705CTlUyT+eGvs++skFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059715; c=relaxed/simple;
	bh=Ws242O5xah0xoOzUmyRDbXa/fc9T7bUDmUjzPUeaeDo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bhGi9JWCCzOA2eeFpDn9F1rSRdpyWsCks/I+1ZIm8OVRTRmXVyzUkjjIwh1fVP7Ys1LoH6aWCZVFVzsmF0n8VqQwqB+JilAS5J3K3xS85JQ8eAXCwgDh9Q998CGODCVupb820U81gfPBv+Y8lECh3WJ7g6HLD9Kel7ZcGTNXcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ck2Vz6iE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ck2Vz6iE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2B1C4CEF7;
	Sat, 21 Mar 2026 02:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774059715;
	bh=Ws242O5xah0xoOzUmyRDbXa/fc9T7bUDmUjzPUeaeDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ck2Vz6iEhaK6Q5BPLU95zOlkUyMZHVsCVcsQ/QCu3AgfEoL+k8ri/Lqo5NHpjLuFx
	 eiahSHamyqEBzIQLdplojEK/CjwMzfB6Eq6QPo/DeCkWyrIiZS0gD7OYIvgh6onRCp
	 0pHXWrgLNc6JIWfLF6+sUUlD0PfUaX7zV4qq8viI=
Date: Fri, 20 Mar 2026 19:21:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Harry Yoo (Oracle)"
 <harry@kernel.org>, linuxppc-dev@lists.ozlabs.org, Harry Yoo
 <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Michal
 Clapinski <mclapinski@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Srikar
 Dronamraju <srikar@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
Message-Id: <20260320192153.759d6fec57f04fb653a0dac7@linux-foundation.org>
In-Reply-To: <h5qax9x2.ritesh.list@gmail.com>
References: <20260319233745.GA769346@ax162>
	<abzKcGiRSR_E8lLN@hyeyoo>
	<7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com>
	<ab1J9ODkX5iChu-C@hyeyoo>
	<7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
	<7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
	<h5qax9x2.ritesh.list@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 06:42:41 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Looks like this is causing regressions in linux-next with warnings
> similar to what Harry also pointed out. Do we have any solution for
> this, or are we planning to hold on to this patch[1] and maybe even
> remove it temporarily from linux-next, until this is fixed?

Yes, I'll disable this patchset.
