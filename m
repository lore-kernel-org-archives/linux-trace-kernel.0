Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC904D9F9C;
	Fri, 25 Sep 2026 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368263; cv=none; b=sjGwsJ8qiM2GMyfn7cm/MvSTs1NHWWNM2UYTTP6PQazgYjKxtv/5v0hZYAUDCAxwyQydXLFmRbz+TJkDvexnsfOgj25ARoyiKTabkciDh5Lv+iDA+S35loq1znVPz2VmAO8TZex4nViNb8leQfS4EDJjUkFuuKhN/Hqegn6JTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368263; c=relaxed/simple;
	bh=IvmJC+wnoMKmtznA56KVh+cnnldg9D+xK7StRD9xfgw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FSXd7gzWUHkBA0OhGqw4HITTmbHBRRlR48bHlYBpJ48TJBrdpA31j9/tvNUf9hiB5zFhhEsaz0FfbV7DcBjhxnwnyp9eJNRkkCgq6a6fjLTMCfpWzN6V8lQTnn4AABsmla9WoM3AHjEmpe+uFQjUj2LTxrdimRtaL9JprnEk0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=R/wLDUhv; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=cjxl5yN/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="R/wLDUhv";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="cjxl5yN/"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790368236; bh=mGecoquQS03nc45mEusf/0T
	7jpG+ELP0oFHt185c/9c=; b=R/wLDUhvneiSr8D/xNGzLXYeVPKdlXPYYKPp8bZ0yA8+wBeJx+
	jiA8n1ZorQ6VCRHRRPWq4F4WFsgZySSu78M/Z2WIqR5a0YKxbnkYBeM3OmtTtFdKD88Xjve+1WO
	QeLvB9aaaF/z+/qw8etz+x6/wMofTlYnTVqiZArAhdNg8AmCgwepLwL+tHnaiXaf+HUdv16rySP
	+ZKmNbH/XMXGE0rSVjlfbQqNVjqoj1V3lWzNRd1V0q5xupgVj3wgud2zQSgjb2XuaW4lUJI7nNp
	jyguD8vpxlcx14d2ychp7ZHoq/bZNzYaWtPhd7RHfGLevx3RrATj5+jKpEtsiHxBItA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790368236; bh=mGecoquQS03nc45mEusf/0T
	7jpG+ELP0oFHt185c/9c=; b=cjxl5yN/mUcKXC59gh0I0U1DWuxO0I5hWFkpUfgXUIZAEbhRGC
	DWM1beTjfTFUg0qQJVf9gOxW9UYh338BKUAg==;
Date: Fri, 25 Sep 2026 21:30:34 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
In-Reply-To: <arbYJUnMkb8Mqbam@monoceros>
References: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com> <arbYJUnMkb8Mqbam@monoceros>
Message-ID: <897D45CE-C577-4DCB-90BA-5DA45AEA307B@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 September 2026 21:28:29 BST, "Uwe Kleine-König"
<u.kleine-koenig@baylibre.com> wrote:
>Hello David,
>
>On Fri, Sep 25, 2026 at 08:20:40PM +0200, Uwe Kleine-König wrote:
>> Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
>> userspace manually messes with devices and drivers") introduced a taint
>> for usage of bind/unbind sysfs files that manually trigger driver probe
>> and remove respectively.
>> 
>> For drivers that do their resource management correctly (which is also
>> needed for module unloading) bind and unbind for matching devices are
>> not critical operations. The thing that makes bind and unbind unsafe is
>> that drivers can be forced on devices that originally don't match using
>> driver_override. The result is that e.g. of_device_get_match_data()
>> returns NULL despite all .of_match_table entries having a non-NULL
>> .driver_data member which yields a NULL pointer exception for several
>> drivers. And given that after setting a driver_override a manual bind is
>> only one way a driver can be bound to an unexpected device, a separate
>> taint for such an override is justified.
>> 
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>
>Sashiko found an issue in the oneline shell script, I fixed that in a
>separate commit because it wasn't introduced in my patch.
>
>Also I violated my own rule not to send patches directly before calling
>it a day and so missed to squash in the build fix that Sashiko also
>found 🤦.
>

Hah! A emoji 🥺

>I wait a bit before sending a v2, but if you want to take a glimpse
>already on the changes I did, look at
>
>	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git driver_override-taint
>
>Best regards
>Uwe
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
