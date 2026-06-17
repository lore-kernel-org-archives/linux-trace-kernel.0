Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7353806D6;
	Wed, 17 Jun 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728679; cv=none; b=UOfP3rTd9jmiOHs6JTMxq/ifrMQFvyva7K/S1WUkMzjLZYc6lbBT/vouJ0z/4Z3ouoMzHz1Sm0s+sW/3XBtzvQIYoZ4rbRAAgc2PlGJAvuJGC92aeLr1cvpsXFvi4qx/ohu449kyooz90as0EQdwxsCaTzamWXozyB2E7bvgtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728679; c=relaxed/simple;
	bh=VuUMURilYXPjm5tx+B3ej9xwudTagcDWx8CzSkngWFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqv7D027nHdeg78yfMeDsGhnneq0fczQS6p0BdhU3LFSY6wMAUq7B6e8OfTKlw7l1OEc6Xjb0i6QKd58SPQi1ZIGpgqZ2iEu0dkmP88FZFCn9oSqoS7eydRQ7kH/UEkVJraVkSfc7kyPyUqvfReNXzFOVMcNJdWwALgGaDoxKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C80181C1CCF;
	Wed, 17 Jun 2026 20:37:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0437220027;
	Wed, 17 Jun 2026 20:37:53 +0000 (UTC)
Date: Wed, 17 Jun 2026 16:37:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL v2] RTLA additional fixes for v7.2
Message-ID: <20260617163751.2a88a9ba@fedora>
In-Reply-To: <20260617153045.546686-1-tglozar@redhat.com>
References: <20260617153045.546686-1-tglozar@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0437220027
X-Stat-Signature: py83sb3oof1qo9ejibg88ckp88fb4wp5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+WlwnidUAaZ4ta78Iio/rYRn7AiCOFvu0=
X-HE-Tag: 1781728673-460393
X-HE-Meta: U2FsdGVkX1/5NuiYJhur5SCiZlhMOy21VvaIvFt+uxNeq4kriRUsT0KEY9tJgX3ht5YzKje9CfZ6g+toVHqmgfZRAcYzwv+nZHjd2eMAygdv9BLZUwPeRU5pbDdroBjBLX0h4Z8EdOPGkfq/9aGedtKncylEIryiNHCY13e6HnRyzbN5Khxla4rEEx427lOUgteFb5h3k/aaWK+EK19mLhqoIjIWW6WMD6Xx5jlIE04jtMdBoEUoc8pMisGFIZj1VjY5qewFYzT7Ju4dhgYw9HFZOB2slmwcHHhvGJ8doFPwB77CI7+D1LPHTxUSrFydcORhXeDxBpwn0H+6ScY5iFaXpwBJ3K9CceqD4CPTG4uwelcQZ31dUg==

On Wed, 17 Jun 2026 17:30:45 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> Steven,
> 
> The following changes since commit 6b5a2b7d9bc156e505f09e698d85d6a1547c1206:
> 
>   Merge tag 'trace-tools-v7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2026-06-16 17:50:34 +0530)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.2-fixups-v2
> 
> for you to fetch changes up to c35eb77a67515d4201bc91294f40761591f43bbd:
> 
>   rtla/tests: Fix pgrep filter in get_workload_pids.sh (2026-06-17 16:26:44 +0200)

Thanks,

As these are fixes they can still go in later in the merge window. This
week I'm really hurting for free time to work on upstream so this may
have to wait until next week. I don't want to rush and screw up again :-/

-- Steve
