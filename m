Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6C345734;
	Fri, 27 Mar 2026 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627909; cv=none; b=Pvo1gWQgaPq6J6macA6xVs1YA88+rBzqOtUV//8GA9L3JXuIQ9fqP7CjPnYloO7tI65+upC5NwhAC6WywmGtpUmOihsbt17jborS4d6x0gm75ENGPkHugH/NWWEvfvpX4YkY3T3HxzE3q/KRhT7jdmvs4k5G4+cGtCKtRg2OtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627909; c=relaxed/simple;
	bh=hDiJ8g3inDfyoclJDAbpK0IGB+dGbUR5h9IqZUd3Q9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txj569G3rcqSN4+wHBynCBqtRJ2eNuk0VRHLfiPWfqsXarktq4nFvUUDsrvIvqUGE4mQOH9ZwvhK1yb8SQqS39kUP+gjpj1fMj2OXI3HJn56XEW2iPb3nCdPJaihTgcyAN6DoDJww7XEowt2ANh2uEDHzkpgeri8Kl8ZWSPAKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZyreVCYx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZyreVCYx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Dbehm6x9kMyE4jYYRsx/CyDHe4PG7PQiTicaVZ25Q4=; b=ZyreVCYxRCiQ+CBtcJ/NlWwBL2
	DVEthxlLwTFME1gmxVmzkwqFhfGSsatMrYGVCeYi3QXDMirgQj2nL/0LMrfINN0WTLS4HE/kc6qlV
	Owa/IZ45KlMUvXAAfK6bYq1e6cG6IkG1yEHXKHcISSpcmtaFhnAFoxKq15Ph5Wybj9LWNH0S+tLZa
	Id0OTmki4OpSgdA/4fsZtoV0N4C6sadREgCmA59+xQtq4zOfB+HNHB/mD0hCZhuDAYNO4fXk6JTzR
	hUpcs8AkXE+EpNUdMX+F7qarR0V5WnSyp/h0WCLuQnqJvaxcfC3sGVx7apB0KIliq5NpE/HdtC95Z
	iPSapv+g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w69mf-00AkKt-0D; Fri, 27 Mar 2026 16:11:41 +0000
Date: Fri, 27 Mar 2026 09:11:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acarcHiUs7yujH4c@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <20260326233042.f52cfc127ec934d52713bce1@kernel.org>
 <acZX_IXQiGwMMi5e@gmail.com>
 <20260327231630.2d6f4273b7d615bda4b51053@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327231630.2d6f4273b7d615bda4b51053@kernel.org>
X-Debian-User: leitao

On Fri, Mar 27, 2026 at 11:16:30PM +0900, Masami Hiramatsu wrote:
> > Given all the feedback on this series, I see three types of issues to address:
> >
> > 1) Minor patch improvements
> > 2) Architecture-specific super early parameters being parsed before bootconfig
> >    is available
> > 3) Unifying kernel cmdline and bootconfig interfaces
>
> I think we can start with 1) for embedded bootconfig for this series
> with using bootconfig in parse_early_param().

Thanks for the clear direction.

I'll work on integrating bootconfig into parse_early_param() to see
what can be achieved and identify any potential blockers.

I should be back soon with more fun.

Thanks so far,
--breno
