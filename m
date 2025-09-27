Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1791F541E;
	Sat, 27 Sep 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758967177; cv=none; b=bIb7xEEcNb3Ilrdaf4zzaxpT82WH4oNvmRmF3849BipWV79xBoo8rtjCSjL9T2f4PbxjRKTVp1fNxHAS/pW0uux3PqWVlEX3dMXgtmdben+JQ4MjRN6WlOSPlgNkCIRDpX+DBnoVqtu2qjmpXo1JdLx3rHONEUYCpaZZjMecc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758967177; c=relaxed/simple;
	bh=fO3nSZSSiqaLLzXsOhX7igmuCudDiWZKHARGLOnekhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1oibeMg2N2iSRoD+6FIABO7WWI7d0tQbRSzLmeA+Nis/Qesv0ZCEjqH8iK3hQDcKCGu82dYiSiuuq54R/TNZZFyQFEhSDGQ/KP9EPx++pAf/98aS+dRoM/9NPQagaLhiwbo+nD9N77+kDG0+LUtq9BwcULNHYdinphGTv/dVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2E6AD13AEA3;
	Sat, 27 Sep 2025 09:59:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id E3A7420027;
	Sat, 27 Sep 2025 09:59:31 +0000 (UTC)
Date: Sat, 27 Sep 2025 05:59:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rtla: fix buffer overflow in actions_parse
Message-ID: <20250927055927.2db5aa50@batman.local.home>
In-Reply-To: <CAP4=nvRPXq=_WterXhaxk1ZwDSPwkJbVJP0L+ze-Cjw1foqK+Q@mail.gmail.com>
References: <cover.1757034919.git.ipravdin.official@gmail.com>
	<164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
	<CAP4=nvRPXq=_WterXhaxk1ZwDSPwkJbVJP0L+ze-Cjw1foqK+Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1rdinnz9fxinrjjr1iyffd9z9oekye8j
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E3A7420027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19bzIHE6O6+HhuldinUylDUmYfvUvPbMgQ=
X-HE-Tag: 1758967171-670296
X-HE-Meta: U2FsdGVkX18yEDxk/iBRbuWzmRDZr7kRHa2UK2z2hfaXOSSqLkfy3sL992L1TPoMnST+SDCm6t2MxNBk7gSkwFz5L9a1+Miqh6Jv8kDglgaqQkJJt8rV9TscLZhH21g7ZC3mkPvjTWP084YkU43IvQ1NTu7EKtTwHVqEMGojedSGNDWcJSeSUr+45WvCHn/KGj/TmI1cnaDVqivKtBn+p/93jQXpM7aTuedMKe0I6Pa62fuF1Tbona23yEKqC+giA8RgORYpdz1lJxTSQaw+aZB9uylzntwNWTGvExCd91nb2cEWEltPbxkEncnAWKa+0w+NDW6+7HJjGXK/JFYqzqAMlQWJl3wk2pEGhkekKGXbAQy/0AwfTg==

On Fri, 26 Sep 2025 16:32:52 +0200
Tomas Glozar <tglozar@redhat.com> wrote:


> Could you take this simple fix? (Might require tweaking the starting
> letter "fix" -> "Fix", I don't care that much about it, but as you
> said, tracing requires capital letters there :) )

Yeah, I can update it.

> 
> The rest of the patchset conflicts with [1] but this one doesn't and
> is also more important.
> 
> [1] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=999703

Should I expect a v4 on patches 2 and 3?

-- Steve
