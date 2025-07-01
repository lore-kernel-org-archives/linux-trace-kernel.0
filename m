Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774C2701C8;
	Tue,  1 Jul 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406246; cv=none; b=XR3yIIIW9WJTFTGM2+W7UC00UkIjZPiWAkN0d7XFS6x/qMSFzDnGGAZxEl9KUPPOQH22QdBZLKk/m51YmCx9PPVRS0iDLa6AB1g0qPh3b0UZyqByP/LeWYb5FK5swKa1Cev5ydNBs0oFMhx1eRAdMMIwqZzVR0macqA17Jyyihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406246; c=relaxed/simple;
	bh=fWpBk2lqDKfDmqSHwqMeo8Bl/Aw2dj3Vg5CyH1owqbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6GDA2zuBZY35YmaCG7P8UQnrG3E8PmLoqrsQCUNGxMnJ/OdO1ldhdv24NOAnTjH1kGUpN0BqF0xfHBmUeAceOGBQTgDyvKR3v73BjVjSTGDN3ns1s79A3n97H//lsAWl0qrMimsEhG2HVSOxsZ4iRgviksE7d8sh38sQJ9C6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 787E5160675;
	Tue,  1 Jul 2025 21:44:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 9A11B2000D;
	Tue,  1 Jul 2025 21:44:00 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:43:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH] Documentation/rtla: Add include common_appendix.rst
Message-ID: <20250701174359.2bae6977@batman.local.home>
In-Reply-To: <20250608104437.753708-2-costa.shul@redhat.com>
References: <20250608104437.753708-2-costa.shul@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A11B2000D
X-Rspamd-Server: rspamout02
X-Stat-Signature: hkzftsfbutcuogshk8fed4eunerdjshb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/n5DMq2R0+gTKdHm3cyahxwmxaueuCico=
X-HE-Tag: 1751406240-664871
X-HE-Meta: U2FsdGVkX1/YZxxOEH8eskrMWivw/6zL+hxKFyqgYHRf2jhr85eCnNCJ6cW/4rWkbSL9TyKo+3OYVyzNUs9bQRrhn2b6KDvYCuy4MwpLNhiXGfrmFB3msCu3v4oatCxniQCYmQD4wNaPs7fU9XigTYPh3LnQ/h1z6XlcSIS4K9j4VSTv7N0qIfeRWIvFwvmVwy5NT+XTR4MTScn/f0T9JVMTZzYnbA70aL3aGmNSebFYn/1DVOc/ufKVsOD9WQqlMf8yE4ze7/R9GPl47RbAq92sZc4yla+KoahkH8IGRnPVLWhH3pKgrCvhJI/lQonltVN35FV222IqJm7hcmYeXGXhOUi45xHnkavtRlRlQxYeoQUVkuhcyq3RdOxXytPYhmrt1pn2uyXg4m25sxhUuKY8w8QK2BVzIE1dAE5siJE=

On Sun,  8 Jun 2025 13:44:36 +0300
Costa Shulyupin <costa.shul@redhat.com> wrote:

> Add include common_appendix.rst into
> Documentation/tools/rtla/rtla-timerlat-hist.rst - the only file of
> rtla-*.rst still without common_appendix.rst.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/tools/rtla/rtla-timerlat-hist.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
> index 03b7f3deb069..b2d8726271b3 100644
> --- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
> +++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
> @@ -107,3 +107,5 @@ SEE ALSO
>  AUTHOR
>  ======
>  Written by Daniel Bristot de Oliveira <bristot@kernel.org>
> +
> +.. include:: common_appendix.rst

