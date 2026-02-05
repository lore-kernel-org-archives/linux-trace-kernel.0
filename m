Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A72F8BEE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321838; cv=none; b=Nyo2hie26ozTk1r3JlKzORAC7uwKlVuq5aCVsnFabyiGHaT7FuMjNBgKQ+4uer1kJ6uXdXd+rV/M68ihUY+hDN3mGLH/1ggKf1mC11DfJi75V6E7hH/VTvZi1HohJMIuWenJ3YwnCTP0+JVyDESGUDUWNooTchEVIz9mVuEq/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321838; c=relaxed/simple;
	bh=UAJhxTyavt/UK+y3PF7lP8VAsvAoUgpNBO3cFPlLp8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=or6p14W/Y0S3Zrk3H9vPLNHp2xkzSq3NosmU5jaM9mg1cxe9zsIbWb3nMRYL00oQ+UqrKYo2UfK8J6Hct+mbMj2nXVKytunr7w87hJWkbTxdYFDAI1WC3Tg4Anah2/Mb8Hg3NmrojrCUONLWOT7mizwOfxCUX5gBgp54yHdNW4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yc0pznEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yc0pznEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770321836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rdv+til5TIZAVq38OLbRG3BWYaNSgDyqCx1NuBwJhM=;
	b=Yc0pznEiU245Gog/lStuwSmA1myTUIGvaKB84MWnuRhkR5EVHHh9EPdrCMxT41EClnWcEu
	xmaUFm04qFH7MIs1VY2csnsVhQYZT8YfuypwkNWaal6HNChP+hjhMAFM+Ef9hpypIWUOs/
	SjwNy2ZNwC4of+yenOjlYNfJNk4sOe4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-OfcP1O0YNie9-ojHI4DHKg-1; Thu,
 05 Feb 2026 15:03:55 -0500
X-MC-Unique: OfcP1O0YNie9-ojHI4DHKg-1
X-Mimecast-MFC-AGG-ID: OfcP1O0YNie9-ojHI4DHKg_1770321834
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 268EF1956096;
	Thu,  5 Feb 2026 20:03:54 +0000 (UTC)
Received: from fedora (unknown [10.22.64.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7342C19560A7;
	Thu,  5 Feb 2026 20:03:51 +0000 (UTC)
Date: Thu, 5 Feb 2026 17:03:49 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/20] rv/rvgen: fix _fill_states() return type
 annotation
Message-ID: <aYT3e6t3i-sVXsc8@fedora>
References: <20260204144914.104028-1-wander@redhat.com>
 <20260204144914.104028-20-wander@redhat.com>
 <7b35a21f1b85e6510b3653ab520920e459160679.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7b35a21f1b85e6510b3653ab520920e459160679.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: FrIPbl5Z-LyIF6SJkW2kyjWgqqbml0iixmCujDhj6t4_1770321834
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 05, 2026 at 08:24:11AM +0100, Gabriele Monaco wrote:
> On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> > The _fill_states() method returns a list of strings, but the type
> > annotation incorrectly specified str. Update the annotation to
> > list[str] to match the actual return value.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> 
> Looks good, thanks. I would keep all annotation changes together (i.e. squash
> with the next patch), but if you prefer this way, I'm fine too.
> 

I don't have strong feelings either way. Feel free to squash them.

> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> >  tools/verification/rvgen/rvgen/ltl2k.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> > b/tools/verification/rvgen/rvgen/ltl2k.py
> > index 2c564cc937235..de765b8486bd1 100644
> > --- a/tools/verification/rvgen/rvgen/ltl2k.py
> > +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> > @@ -71,7 +71,7 @@ class ltl2k(generator.Monitor):
> >          if not self.name:
> >              self.name = Path(file_path).stem
> >  
> > -    def _fill_states(self) -> str:
> > +    def _fill_states(self) -> list[str]:
> >          buf = [
> >              "enum ltl_buchi_state {",
> >          ]
> 

