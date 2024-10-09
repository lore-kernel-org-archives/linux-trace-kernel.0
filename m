Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F619ABB4;
	Wed,  9 Oct 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485153; cv=none; b=WupLqlmVmkTY/jLqDFT5AyesHjxIyNErVry+KAjOtGHzuZ7YRC3N6seMnnTPWDw77kZ5rH2Qp5rrEgsOmLUl6OVPEBJODb7DCnBQoiul5rq2HR/GGTSgH0uoIshAXsmwOzBvBhq57uE1hxc8zkc1Ybmjhvk0mirrOrKPe/WF3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485153; c=relaxed/simple;
	bh=0rGXRXrVEzv1pUncDBmhW3w/UvAzQdnDVWOx8UrEEwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4dfaKWg1QvTT8M9Pltbay26VckcqEAD+yaQGdCthv+e+TtBGG9mdzI0dnENpWfMfQez0Vr7+bEUj+s/sOyvB2obbTKYZTVABVdUbkBtDCsLRuPqg1J8fHzsNyoNfEsnaJO2G62hUxZEoXpFJIV8RJfQuay/yzdolZXmQvSLkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C704FC4CEC3;
	Wed,  9 Oct 2024 14:45:51 +0000 (UTC)
Date: Wed, 9 Oct 2024 10:45:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and
 printing the function return address
Message-ID: <20241009104556.333bca30@gandalf.local.home>
In-Reply-To: <CAErzpms1mGeBw364qsX1YV_4=4sPhMhTRsWsjHZmH8Ro5xWoyQ@mail.gmail.com>
References: <20241009030340.16400-1-dolinux.peng@gmail.com>
	<20241009093727.4e99c1e2@gandalf.local.home>
	<CAErzpms1mGeBw364qsX1YV_4=4sPhMhTRsWsjHZmH8Ro5xWoyQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 22:01:51 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> > Is there a reason for the resend? I already have it in my for-next branch.  
> 
> I'm sorry and I did not notice it.

You were Cc'd:

  https://lore.kernel.org/all/20241005191308.384922133@goodmis.org/

That's why I send these out.

-- Steve
