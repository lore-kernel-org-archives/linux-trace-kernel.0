Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4ED4DBD9F;
	Wed,  3 Jun 2026 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528599; cv=none; b=E6uwJq3FvgL4WVSG9JYOzhzAl4GrXqbURDr/GXV8e36MwBdajLXuND2jBe8yXldZ3cZOgG2OQb3cH5XlSekGcJg4uofGrVUw96XftX+yJSrh2YS/pH9zlyk15NdXl9fLhO02ghl2j0oec3rSXcaZCHLw8mhZTav7BpC3/N7zjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528599; c=relaxed/simple;
	bh=MJjnxfflC4OSMdji0tNpAT0azswgulmQdjQI03gsXZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3pZQTeAFkk9xnpU+uE7RLNKaK+Y2QsYbe1SMVZrnrwNSA5+7f0/8CvhRh8brYfB6uTajgA1ds92LxzeimM0KOJeIOTSVKqw/HEbvoOwDTdabzO1PChA9IChZNo4pvM0H7o+QGVLV3CDLbC2i+0IcngP5kzifxzOvvpWTTQlTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id BE40E120564;
	Wed,  3 Jun 2026 23:16:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 137A817;
	Wed,  3 Jun 2026 23:16:29 +0000 (UTC)
Date: Wed, 3 Jun 2026 19:16:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 unknownbbqrx <dev@unknownbbqr.xyz>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [GIT PULL] rv fixes for v7.1
Message-ID: <20260603191627.5cb4ef6c@fedora>
In-Reply-To: <20260603125056.75559-1-gmonaco@redhat.com>
References: <20260603125056.75559-1-gmonaco@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 137A817
X-Stat-Signature: kyy8abnrrxttisw3ndaw4xqmr56n9zt6
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19X2CwodvmoZjfBgw9/AkKUD0RQEE/VGgs=
X-HE-Tag: 1780528588-761654
X-HE-Meta: U2FsdGVkX188nZUlPmVNXywPnzg0PVul+O31OLfHnIJVIXYSl3TeyAvwlR45Ox5y4CbrDVu4wurYT4A7MNIACpAemCQWiQH08n7pIlN5/PfQc66yhGE8NVb7XgdWBTIbqhO9J+HU0kCbMQ8PnCvfVrfg+lNapxZnHnnrOxnjGyqG9NMMulrZCDmGPJDJ1qUUtR9F18/ole5EMOtsajCOXNGFGp+TLa2ZJ6aT50rP1T/jeaAfrNFB0D7MRPL1OfqPmYXKRQOtkrSvhPMFMvYbq/SVuUnEN5f0RawfhoK6KuU1xpfLMp8xFzGJ7ROUTuE3Z733OHFnLE6X+efuf7FpElmkIbOhtG8Ip9I4kgJOLQjMYwtLkLQZV+jeyvZqxOEQp9S1HVazYZs=

On Wed,  3 Jun 2026 14:50:56 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> unknownbbqrx (1):
>       tools/rv: Ensure monitor name and desc are NUL-terminated

Hi Gabriele,

What is this? All commits need to be authored by and signed off by from
a real person with their official name.

 https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

-- Steve
