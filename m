Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA33FF1;
	Fri, 29 May 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063014; cv=none; b=eo4DdlD60mghNyV/ChTOv7A/SPja4CxAkpHEBu/LIQBclX4T6mVvLmUmz/FAI66Cav33DegqUq3FFutOPi/we4osBIAkIlXFx7HHwUJhld16zdCQYfNSutRUF3Ir4+eQ30CV/NiJQvpo+lOzWRkXXzDjR8LzYYEm/VeOPpylG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063014; c=relaxed/simple;
	bh=8qbF1apLhDnKZvvTELGdtOM9C/PjT+Bsr0FI/FVLbUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+v2coXZoovbCR4BzY7dlzBz9kWSuwaIV0mkoTnXzRjxSPM56PJZhzNsY9GkJ9sHeeH6+cL3PeqE60/ftkF7lhh5qwAdswJm0U6gsw04cIzFxpVMvOlbjwWsYresIV1fMe01ttf21Rj632Q8NCIUfTi35BefcmiMHmH1D4k8i3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5097C8B5E8;
	Fri, 29 May 2026 13:56:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 7E9C86000C;
	Fri, 29 May 2026 13:56:49 +0000 (UTC)
Date: Fri, 29 May 2026 09:56:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood
 <crwood@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for 7.2
Message-ID: <20260529095646.73c95f60@fedora>
In-Reply-To: <20260529130643.3080315-1-tglozar@redhat.com>
References: <20260529130643.3080315-1-tglozar@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E9C86000C
X-Stat-Signature: j9fyft7ixifnkhdb7wb8h41widwp7qdc
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18U1123CA37GC8345VkXpRrYF9zd2q7Y1k=
X-HE-Tag: 1780063009-190567
X-HE-Meta: U2FsdGVkX18LNxtVAU6sFx2vqi0L0h5GcwriIfwiW1AX5IUuM0ojSmMvV2MEDKiqRofIQP+9fPkkgaQAJhMtPfQVjK6lcVXHK227JNj8Sf5I/bBgvYdWfAwZFyI9oSGvBnRK03D5+YsulqBTNSzpgC18+GxialZE+EAbmkTy6irs3H4t1tlVBwR66uATnSI8C7ZMzUgwECj+FGGf9DTVjEslfceiVQOGUUtvLerlcBGr2nBfjsPnBR8tFzRJKnO5MQ5p8nym6jf1rpKVGqKzQrNzpk//iFvmoqAJq8jZ21J0072KBCzdf4mr9sQ2tpI+fTchclARtBdGu4HJFe5agV+zwygI7xUw

On Fri, 29 May 2026 15:06:43 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> - Fix discrepancy in --dump-tasks option
> 
> Due to a mistake, rtla-timerlat-hist used the CLI syntax "--dump-task"
> instead of the documented "--dump-tasks". Change the option to match
> both documentation and the other timerlat tool, rtla-timerlat-top.

Is there any concern that scripts might be using the old option? 

I wonder if you should keep the old option for backward compatibility,
but do not document that it exists.

-- Steve
