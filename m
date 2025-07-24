Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5492E5B18;
	Thu, 24 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365397; cv=none; b=tZSYtUmpOpFA2HVArxak1ZU6PoHtVfEl6bOjnssRoyEMkps2DEIvvTO1Tl9/Cq2o5PGklUo5FJxpbkn6ALj7F/56edfYtGEVUpdhCVLVVRpUk1qb6jEw/ukhn3AbSxQEc3akzZCDHNRRE3DJaBbME7Ww7CWfU7Sb36RBMe8JLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365397; c=relaxed/simple;
	bh=zXgA8lHW0hAXguf0NySAm846eipCgZK0RLnszlxmNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh2v5LoNjAY9EFXr+aQi/nKSIZyV3hE7CgbFI0ptAJPEvYRg8e/BLvDql+MNNeWrK5nGjxrxveDmwKJdCk76YLQ5Axcr8NDP2fwU6lrOiXcG1PTseTkTmfwQkYccWe4qYOLu+w+LIZLar1Gl9FKTfmchzZ4wIA/ZLemCVdwwfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2F6A8112CE8;
	Thu, 24 Jul 2025 13:56:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 7E2EF20016;
	Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:56:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: bristot@kernel.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: clarify trace option syntax in documentation and
 usage help
Message-ID: <20250724095627.572c1cff@batman.local.home>
In-Reply-To: <20250723015233.173630-1-ipravdin.official@gmail.com>
References: <20250723015233.173630-1-ipravdin.official@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E2EF20016
X-Stat-Signature: u1x4nsdsrq3sbbrj159i8ikb6kk7wp3r
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1979Ti/pUfl2nQHOueWSP8llgjuM4vcdOE=
X-HE-Tag: 1753365390-589962
X-HE-Meta: U2FsdGVkX18VDHmHgh2esz13Ti8MTfMv6D4JNqbRv25UTYFowtc6dFfbfrHP4Iwa56telsCl/iB6Lk5iwhMleJHRH3ajowTqROyWuWQIgL08mkXGS0AF7ZCupd+Miv6Gy2SjuUepWrgTAYiH7+Dn++JMiBvClCop4lxt9x6zOJB5gM+xNaucHtmBFGopl6dQpIXx1iyLuwD3nEfqpT6LqLX0bV83G87iMuNS9NujPHPO0zRKomUAbkis3Z/rVJUthExUoKLOBNfFl4EBAWpcPk/IYyeuzCdqHuUZEUB876YH4zzEvaX6EhLRXJV776LnyHf1y2GNnbysbhgH09bZfcLNlV2IrjDw

On Tue, 22 Jul 2025 21:52:33 -0400
Ivan Pravdin <ipravdin.official@gmail.com> wrote:

> When using `rtla timerlat {top,hist}`, the `-t/--trace` option is
> optional. However, when providing a filename, the long option requires
> an equal sign (`=`), i.e., `--trace=<file>`. This is because the
> command-line parser treats `--trace` without `=` as a flag with no
> value, leading to unexpected behavior.
> 
> Valid usage:
>     - `-t[file]`
>     - `-t=[file]`
>     - `--trace=[file]`
> 
> Invalid usage:
>     - `-t [file]`
>     - `--trace [file]`

I wonder if the better fix would be to make the above valid?

-- Steve


> 
> Clarify valid usage in documentation and help message.
> 
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
